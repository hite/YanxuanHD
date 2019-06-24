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
    
    lazy var tapGesture = self.getTapGesture()
    
    init(_ banners: [BannerImageModel]) {
        self.banners = banners
    }
    
    private func getTapGesture() -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(tapBanner(_:)))
        return tapGesture
    }
    
    @objc func tapBanner(_ sender: UIGestureRecognizer) {
        let index = sender.view!.tag
        let bannerModel = self.banners[index]
        let vc = UIHostingController(rootView: Text("What does the fox say"))
        print("Go to url \(bannerModel.destinationURL)")
        
        guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
            print("fail get root viewController")
            return
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
}


struct BannerScrollView : UIViewRepresentable{
    var userData: BannerData
    var actionDelegate: BannerActionDelegate
    func makeCoordinator() -> Coordinater {
        Coordinater(self)
    }
    
    init(_ userData: BannerData) {
        self.userData = userData
        self.actionDelegate = BannerActionDelegate(userData.bannes)
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
        
        // 使用数据填充 View
        let list = self.userData.bannes
        let w = self.userData.imageWidth, h = self.userData.imageHeight
        uiView.contentSize = CGSize(width: CGFloat(list.count) * w, height: h)
        
        let renderImage: (Int, UIImage) -> Void = { (idx, imageData)in
            let img = UIImageView(image: imageData)
            img.frame = CGRect.init(x: CGFloat(idx) * w, y: 0, width: w, height: h)
            img.tag = idx
            
            img.addGestureRecognizer(self.actionDelegate.tapGesture)
            uiView.addSubview(img)
        }
        
        for (index, imageModel) in self.userData.bannes.enumerated() {
            
            let bannerData = BannerImageData(imageModel)
            let observer: Subscribers.Sink<Publishers.Once<BannerImageData, Never>> = Subscribers.Sink(receiveCompletion: {
                print("completed: \($0)")
            }, receiveValue: {
                print("received value: \($0)")
                if let imageData = $0.imgData {
                    renderImage(index, imageData)
                }
            })
            bannerData.didChange.subscribe(observer)
            
            if let imageData = bannerData.imgData {
                renderImage(index, imageData)
            }
            
        }
    }
    
    
    class Coordinater: NSObject, UIScrollViewDelegate {
        var scroll: BannerScrollView
        
        init(_ control: BannerScrollView) {
            self.scroll = control
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
        BannerScrollView(BannerData.init("", size: CGSize.init(width: 200, height: 100)))
        
    }
}
#endif
