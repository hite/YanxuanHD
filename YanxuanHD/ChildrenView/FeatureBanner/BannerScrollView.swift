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
        
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        guard let rootViewController = keyWindow?.rootViewController else {
            print("fail get root viewController")
            return
        }
        
        rootViewController.present(vc, animated: true, completion: nil)
    }
}


struct BannerScrollView : UIViewRepresentable{

    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    var userData: BannerData
 
    func makeCoordinator() -> Coordinater {
        Coordinater(self)
    }
    
    init(imageWidth: CGFloat, imageHeight: CGFloat, banner: BannerData) {
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.userData = banner
        print("\(imageWidth) = userData.imageWidth")
    }
    
    func makeUIView(context: UIViewRepresentableContext<BannerScrollView>) -> UIView {
        
        let container = UIView()
        
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.delegate = context.coordinator
        container.addSubview(sv)
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sv.leftAnchor.constraint(equalTo: container.leftAnchor),
            sv.topAnchor.constraint(equalTo: container.topAnchor),
            sv.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            sv.rightAnchor.constraint(equalTo: container.rightAnchor)
        ])
        
        // pageSize
        let pageControl = UIView()
        pageControl.backgroundColor = .init(white: 0, alpha: 0.5)
        pageControl.frame = CGRect(x: 0, y: 10, width: 40, height: 20)
        pageControl.clipsToBounds = true
        pageControl.layer.cornerRadius = 4
        let label = UILabel()
        label.frame = pageControl.bounds
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        label.text = "1 / 4"
        label.textAlignment = .center
        pageControl.addSubview(label)
        container.addSubview(pageControl)
        print("BannerScrollView makeUIView")
        return container
    }
    
    func updateScrollView(_ scrollView: UIScrollView, banners: [BannerImageModel], in context: UIViewRepresentableContext<BannerScrollView>) -> Void {
        // 使用数据填充 View
        print("UIScrollView size = \(scrollView.frame)")
        // 先把位置占好
        scrollView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        scrollView.setContentOffset(.zero, animated: true)
        
        let w = self.imageWidth, h = self.imageHeight
        context.coordinator.actionDelegate = BannerActionDelegate(banners)
        
        scrollView.contentSize = CGSize(width: CGFloat(banners.count) * w, height: h)
        
        for idx in 0...banners.count - 1 {
            let img = UIImageView()
            img.frame = CGRect.init(x: CGFloat(idx) * self.imageWidth, y: 0, width: self.imageWidth, height: self.imageHeight)
            img.tag = idx
            img.contentMode = .scaleAspectFit
            
            img.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer()
            tap.addTarget(context.coordinator.actionDelegate!, action: #selector(BannerActionDelegate.tapBanner))
            img.addGestureRecognizer(tap)
            scrollView.addSubview(img)
        }
        let updateImage: (Int, UIImage) -> Void = { (idx, imageData) in
            if idx < scrollView.subviews.count {
                if let img = scrollView.subviews[idx] as? UIImageView {
                    img.image = imageData
                }
            }
        }
        
        for (index, imageModel) in banners.enumerated() {
            
            let bannerData = BannerImageData(imageModel)
            // https://icodesign.me/posts/swift-combine/
            if let imageData = bannerData.imgData {
                updateImage(index, imageData)
            } else {
                
                let _ = bannerData.willChange.sink { (bannerData) in
                    //
                    print("received value: \(bannerData)")
                    if let imageData = bannerData.imgData {
                        updateImage(index, imageData)
                    }
                }
            }
        }
        
        context.coordinator.updatePageControl(scrollView)
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BannerScrollView>) {
        print("What? ")
 
        let userData: BannerData = self.userData
        guard let scrollView = uiView.subviews.first as? UIScrollView else {
            print("UIScrollView doesn\t exsits")
            return
        }
        if userData.bannes.count > 0 {
            self.updateScrollView(scrollView, banners: userData.bannes, in: context)
        }
        let _ = userData.willChange.sink { (ud) in
            // 使用数据填充 View
            self.updateScrollView(scrollView, banners: ud.bannes, in: context)
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
            self.updatePageControl(scrollView)
        }
        func updatePageControl(_ scrollView: UIScrollView) -> Void {
            let singleWidth = scrollView.subviews.first?.bounds.size.width ?? self.scroll.imageWidth
            let currentIdx = Int(scrollView.contentOffset.x / singleWidth) + 1
            
            if let num = scrollView.superview?.subviews.last?.subviews.first as? UILabel {
                num.text = "\(currentIdx) / \(Int(scrollView.contentSize.width / singleWidth))"
            }
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
        BannerScrollView(imageWidth: 200, imageHeight: 100, banner: BannerData("", width: 200, height: 100))
    }
}
#endif
