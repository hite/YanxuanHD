//
//  Sidebar.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/19.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct Sidebar : View {
    var body: some View {
        VStack {
            ProfileView()
            Divider()
            ForEach(sidebarMenuItems) { menu in
                
                if menu.isSpacer {
                    Spacer()
                } else {
                    SidebarMenu(imageName: menu.imageName, title: menu.title)
                }
            }
        }.padding(.bottom, 5)
    }
}

#if DEBUG
struct Sidebar_Previews : PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
#endif
