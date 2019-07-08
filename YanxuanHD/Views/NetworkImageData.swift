//
//  NetworkImageData.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/30.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Kingfisher

var kMiniCacheForImg = [String: UIImage?](minimumCapacity: 100)

final class NetworkImageData: BindableObject {
    let didChange = PassthroughSubject<NetworkImageData, Never>()
    
    var imageURL: String
    
    var imgData: UIImage? {
        didSet {
            didChange.send(self)
        }
    }
    
    init(_ imageURL: String) {
        self.imageURL = imageURL
        
        self.downloadImage()
    }
    
    func downloadImage() -> Void {
        
        if self.imgData != nil {
            return
        }
        if self.imageURL.hasPrefix("http://") || self.imageURL.hasPrefix("https://") {
            
            guard let url = URL(string: self.imageURL) else {
                print("imageURL error")
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
        } else {
            self.imgData = UIImage.init(named: self.imageURL)
        }
        
    }
}
