//
//  ContentView.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/19.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI


struct ContentView : View {
    let activeTabData = ActiveTabData()
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Sidebar()
                .environmentObject(activeTabData)
                .frame(width: 130)
                .fixedSize(horizontal: true, vertical: false)
                .background(Color.init(red: 0.15, green: 0.11, blue: 0.06))
            
            ChildrenContent()
                .environmentObject(activeTabData)
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
