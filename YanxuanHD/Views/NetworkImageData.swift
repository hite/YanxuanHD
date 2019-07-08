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
            
//            if let cacheHit = kMiniCacheForImg[self.imageURL] {
//                self.imgData = cacheHit
//                return
//            }
            
            DispatchQueue.global(qos: .default).async {
                if let data = try? Data(contentsOf: url) {
                    print("Downloading Image..\(url)")
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imgData = image
                        }
                        
                        //TODO kMiniCacheForImg.removeAll(keepingCapacity: true)
//                        kMiniCacheForImg[self.imageURL] = image
                    }
                }
            }
        } else {
            self.imgData = UIImage.init(named: self.imageURL)
        }
        
    }
}
