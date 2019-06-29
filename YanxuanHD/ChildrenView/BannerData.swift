//
//  BannerData.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/21.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class BannerData: BindableObject {

    let didChange = PassthroughSubject<BannerData, Never>()
    
    var bannes: [BannerImageModel] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    var url: String
    
    init(_ url: String, width: CGFloat, height: CGFloat) {
        self.url = url
        self.updateData(imageWidth: width, imageHeight: height)
    }
    
    func updateData(imageWidth: CGFloat, imageHeight: CGFloat) -> Void {
//        let scale = UIScreen.main.scale
        let imgsURLs = [
            ("https://yanxuan.nosdn.127.net/ad787884a51be3cf9df166566577ff10.jpg?imageView&quality=95","https://act.you.163.com/act/pub/nDFLuzkE7Q.html?_stat_referer=index&_stat_area=banner_5"),
            ("https://yanxuan.nosdn.127.net/c47d36d7247a6c7ecd390c3b18921868.jpg?imageView&quality=95","https://act.you.163.com/act/pub/hiir9OcR1l.html?_stat_referer=index&_stat_area=banner_4"),
            ("https://yanxuan.nosdn.127.net/33b614fa5c7d36c1ee341a2a9d5f11ce.jpg?imageView&quality=95","https://act.you.163.com/act/pub/2dxYrg3pAi.html?_stat_referer=index&_stat_area=banner_3"),
            ("https://yanxuan.nosdn.127.net/b3d2aba21e4bd12dff153142222b1c2a.jpg?imageView&quality=95","https://act.you.163.com/act/pub/uyl9wjD97p.html?_stat_referer=index&_stat_area=banner_1")
        ]
        
        var idx = 0
        
        DispatchQueue.global(qos: .default).async {
            print("Wait a minites..")
            DispatchQueue.main.async {
                self.bannes = imgsURLs.map { (arg0) -> BannerImageModel in
                    let (img, url) = arg0
                    let imageUrl = img + "&thumbnail=\(Int(imageWidth * 1))x\(Int(imageHeight * 1))"
                    print("Downloading \(imageUrl)")
                    idx += 1
                    return BannerImageModel(id: idx, imageURL: imageUrl, destinationURL: url)
                }
            }
        }
    }
}
