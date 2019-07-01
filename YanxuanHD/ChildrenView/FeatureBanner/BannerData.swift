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
        
        Networking.fetch(.banners) { (r) in
            var list: [BannerImageModel] = []
            if let items = r as? [Dictionary<String, Any>]{
                for item in items {
                    let model = BannerImageModel(from: item)
    
                    let imageUrl = model.imageURL + "?imageView&quality=95&thumbnail=\(Int(imageWidth * 2))x\(Int(imageHeight * 2))"
                    print("Downloading \(imageUrl)")
                    model.imageURL = imageUrl
                    list.append(model)
                    print(item)
                }
                
                self.bannes = list
            }
        }

    }
}
