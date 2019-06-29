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

    var body: some View {
        VStack {
            if self.activeTabData.activeMenuItem.id == 1001 {
                FeatureTab()
            } else {
                Text("正品保障 \(self.activeTabData.activeMenuItem.title)")
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
