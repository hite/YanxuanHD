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
    var tabIndex: Int = 0

    var body: some View {
        VStack {
            if self.tabIndex == 0 {
//                CategorySegment()
                FeatureTab().environmentObject(BannerData.init(""))
            } else {
                Text("正品保障")
            }
        }
    }
    
    
}

#if DEBUG
struct ChildrenContent_Previews : PreviewProvider {

    static var previews: some View {
        ChildrenContent(tabIndex: 0)
    }
}
#endif
