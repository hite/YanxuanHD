//
//  BannerImage.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/20.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI
import UIKit

class BannerImageModel: Identifiable {
    static func == (lhs: BannerImageModel, rhs: BannerImageModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int

    var imageURL: String
    
    var destinationURL: String
    
    init(id: Int, imageURL: String, destinationURL: String) {
        self.id = id
        self.imageURL = imageURL
        self.destinationURL = destinationURL
        
    }
}


struct BannerImage : View {
    @EnvironmentObject var userData: BannerImageData

    var body: some View {
        VStack {
            if self.userData.imgData != nil {
                Image(uiImage: self.userData.imgData!)
            } else {
                Image("home-banner-sample")
            }
        }
    }
}

#if DEBUG
struct BannerImage_Previews : PreviewProvider {
    static let sampe = BannerImageModel.init(id: 1, imageURL: "https://yanxuan.nosdn.127.net/6d83b8e30b1d0a0874dbb068dfc2503a.jpg?imageView&quality=95&thumbnail=1090x310", destinationURL: "https://act.you.163.com/act/pub/nDFLuzkE7Q.html?_stat_referer=index&_stat_area=banner_5")
    static var previews: some View {
        BannerImage().environmentObject(BannerImageData(sampe))
    }
}
#endif
