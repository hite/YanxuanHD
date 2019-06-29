//
//  BannerScrollView.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/24.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

// 在 struct 结构里不能定义 @objc 的方法，所以独立出来
class BannerActionDelegate {
    var banners: [BannerImageModel]
    
    init(_ banners: [BannerImageModel]) {
        self.banners = banners
    }

    @objc func tapBanner(_ sender: UIGestureRecognizer) {
        let index = sender.view!.tag
        let bannerModel = self.banners[index]
        let vc = UIHostingController(rootView: WebView(urlString: bannerModel.destinationURL))
        print("Go to url \(bannerModel.destinationURL)")
        
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            print("fail get root viewController")
            return
        }
        
        rootViewController.present(vc, animated: true, completion: nil)
    }
}


struct BannerScrollView : UIViewRepresentable{
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    func makeCoordinator() -> Coordinater {
        Coordinater(self)
    }
    
    init(imageWidth: CGFloat, imageHeight: CGFloat) {
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        print("\(imageWidth) = userData.imageWidth")
    }
    
    func makeUIView(context: UIViewRepresentableContext<BannerScrollView>) -> UIScrollView {
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.delegate = context.coordinator

        return sv
    }
    
    func updateUIView(_ uiView: UIScrollView, context: UIViewRepresentableContext<BannerScrollView>) {
        print("What? ")
        
        let renderImage: (Int, UIImage) -> Void = { (idx, imageData)in
            let img = UIImageView(image: imageData)
            img.frame = CGRect.init(x: CGFloat(idx) * self.imageWidth, y: 0, width: self.imageWidth, height: self.imageHeight)
            img.tag = idx
            
            img.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer()
            tap.addTarget(context.coordinator.actionDelegate!, action: #selector(BannerActionDelegate.tapBanner))
            img.addGestureRecognizer(tap)
            uiView.addSubview(img)
        }

        let userData: BannerData = context.coordinator.fetchUserData()
        let _ = userData.didChange.sink { (ud) in
            // 使用数据填充 View
            uiView.subviews.forEach { (view) in
                view.removeFromSuperview()
            }
            
            
            let w = self.imageWidth, h = self.imageHeight
            let banners = ud.bannes
            context.coordinator.actionDelegate = BannerActionDelegate(banners)
            
            uiView.contentSize = CGSize(width: CGFloat(banners.count) * w, height: h)
            
            for (index, imageModel) in banners.enumerated() {
                
                let bannerData = BannerImageData(imageModel)
                // https://icodesign.me/posts/swift-combine/
                let _ = bannerData.didChange.sink { (bannerData) in
                    //
                    print("received value: \(bannerData)")
                    if let imageData = bannerData.imgData {
                        renderImage(index, imageData)
                    }
                }
                
                if let imageData = bannerData.imgData {
                    renderImage(index, imageData)
                }
            }
            
        }
    }
    
    
    class Coordinater: NSObject, UIScrollViewDelegate {
        var scroll: BannerScrollView
        var actionDelegate: BannerActionDelegate?
        
        init(_ control: BannerScrollView) {
            self.scroll = control
        }
        
        func fetchUserData() -> BannerData {
            let r = BannerData("", width: self.scroll.imageWidth, height: self.scroll.imageHeight)
            
            return r
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            print("Srolling did end, offset.x = \(scrollView.contentOffset.x)")
        }
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            self.scrollViewDidEndDecelerating(scrollView)
        }
    }
 
}

#if DEBUG
struct BannerScrollView_Previews : PreviewProvider {
    static let sampe = BannerImageModel.init(id: 1, imageURL: "https://yanxuan.nosdn.127.net/6d83b8e30b1d0a0874dbb068dfc2503a.jpg?imageView&quality=95", destinationURL: "https://act.you.163.com/act/pub/nDFLuzkE7Q.html?_stat_referer=index&_stat_area=banner_5")
    
    static var previews: some View {
        BannerScrollView(imageWidth: 200, imageHeight: 100)
    }
}
#endif
