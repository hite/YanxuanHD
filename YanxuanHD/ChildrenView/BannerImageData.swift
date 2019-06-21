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
        guard let url = URL(string: self.imageModel.imageURL) else {
            return
        }
        
        DispatchQueue.global(qos: .default).async {
            if let data = try? Data(contentsOf: url) {
                print("Downloading Image..")
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imgData = image
                    }
                }
            }
        }
        
    }
}
