//
//  FeatureTab.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/20.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct FeatureTab : View {
    @EnvironmentObject var userData: BannerData
    var body: some View {
        VStack {
            ScrollView(showsHorizontalIndicator: false) {
                HStack(spacing: 0) {
                    ForEach(self.userData.bannes) { bannerModel in
                        BannerImage().environmentObject(BannerImageData(bannerModel))
                    }
                    }
                    
                    .frame(height: 155)
                    .padding(0)
            }
        }
    }
    
}


#if DEBUG
struct FeatureTab_Previews : PreviewProvider {
    static let sampe = BannerImageModel.init(id: 1, imageURL: "https://yanxuan.nosdn.127.net/6d83b8e30b1d0a0874dbb068dfc2503a.jpg?imageView&quality=95&thumbnail=1090x310", destinationURL: "https://act.you.163.com/act/pub/nDFLuzkE7Q.html?_stat_referer=index&_stat_area=banner_5")

    static var previews: some View {
        FeatureTab().environmentObject(BannerData.init(""))
    }
}
#endif
