//
//  Sidebar.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/19.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct Sidebar : View {
    @EnvironmentObject var activeTabData: ActiveTabData
    
    let orientationDidChangePublisher = NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)
    
    @State var orientation = UIDevice.current.orientation

    var body: some View {
        VStack {
            ProfileView()
            Divider()
            ForEach(sidebarMenuItems) { menu in
                
                if menu.isSpacer {
                    Spacer()
                } else {
                    SidebarMenu(smaller: false, model: menu, activeData: self.activeTabData, isSelected: self.activeTabData.activeMenuItem.id == menu.id)
                }
            }
        }.padding(.bottom, 5)
        .onReceive(orientationDidChangePublisher) { (notif) in
            print("Notificaton = \(notif)")
            self.orientation = UIDevice.current.orientation
        }
    }
}

#if DEBUG
struct Sidebar_Previews : PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
#endif
