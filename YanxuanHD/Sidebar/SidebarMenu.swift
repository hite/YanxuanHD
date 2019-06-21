//
//  SidebarMenu.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/19.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct SidebarMenu : View {
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .scaleEffect(1/2, anchor: .center)
            .padding(-20)
            
            self.titleView(5)
        }
    }
    
    func titleView(_ offset: Double) -> some View {
        let top = -2 * offset
        
        return Text(self.title).color(.white)
            .font(Font.subheadline)
            .fontWeight(.bold)
            .padding(EdgeInsets(top: Length(top), leading: 0, bottom: Length(offset), trailing: 0))
    }

}

#if DEBUG
struct SidebarMenu_Previews : PreviewProvider {
    static var previews: some View {
        SidebarMenu(imageName: "sidebar-search", title: "搜索").background(Color.black)
    }
}
#endif
