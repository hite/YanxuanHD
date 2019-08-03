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

    // bannerData 数据源放在 list 外面避免被内部缓存丢弃后的重绘

    var body: some View {
        VStack {
            if self.activeTabData.activeMenuItem.id == 1001 {
               GeometryReader { geo in
   
                FeatureTab(
                    singleWidth: geo.size.width,
                    singleHeight: 150,// 用变量就不行？
                    bannerData: BannerData("", width: geo.size.width, height: 150),// 用变量就不行？
                    overSeaData: OverseaData(),
                    newArrivalData: NewArrivalData(),
                    flashSaleData: FlashSaleData(),
                    fulisheData: FulisheData())
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
