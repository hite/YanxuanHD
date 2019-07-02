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
        guard let url = URL(string: self.imageURL) else {
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
