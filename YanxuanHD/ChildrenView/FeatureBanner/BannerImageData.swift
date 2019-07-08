//
//  BannerImageData.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/21.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Kingfisher

final class BannerImageData: BindableObject {
    let didChange = PassthroughSubject<BannerImageData, Never>()
    
    var imageModel: BannerImageModel
    
    var imgData: UIImage? {
        didSet {
            didChange.send(self)
        }
    }
  
    init(_ model: BannerImageModel) {
        self.imageModel = model
        
        self.downloadImage()
    }
    
    func downloadImage() -> Void {
        if self.imgData != nil {
            //
            print("Skip download image")
            return
        }
        guard let url = URL(string: self.imageModel.imageURL) else {
            print("imageModel.imageURL error")
            return
        }
        
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let value):
                print("Downloading Image..\(url)")
                self.imgData = value.image
            case .failure:
                print("Downloading Image fails..\(result)")

            }
        }
        
    }
}
