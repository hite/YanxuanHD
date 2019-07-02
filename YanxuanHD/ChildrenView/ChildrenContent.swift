//
//  ChildrenContent.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/19.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

// 默认首页的布局和样式
struct ChildrenContent : View {
    @EnvironmentObject var activeTabData: ActiveTabData

    let bannerImageHeight: Length = 150
    // bannerData 数据源放在 list 外面避免被内部缓存丢弃后的重绘
    var body: some View {
        VStack {
            if self.activeTabData.activeMenuItem.id == 1001 {
                GeometryReader { geo in
                    FeatureTab(singleWidth: geo.size.width, singleHeight: self.bannerImageHeight, bannerData: BannerData("", width: geo.size.width, height: self.bannerImageHeight))
                }
                
            } else if(self.activeTabData.activeMenuItem.url.count > 0 ){
                WebView(urlString: self.activeTabData.activeMenuItem.url)
            }
        }
    }
    
    
}

#if DEBUG
struct ChildrenContent_Previews : PreviewProvider {

    static var previews: some View {
        ChildrenContent()
    }
}
#endif
