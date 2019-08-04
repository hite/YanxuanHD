//
//  ContentView.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/19.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

let kBrandColor = Color.init(red: 0.83, green: 0.16, blue: 0.18)
let kBrandUIColor = UIColor.init(red: 0.83, green: 0.16, blue: 0.18, alpha: 1)

struct ContentView : View {
    var activeTabData = ActiveTabData()
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Sidebar()
                .environmentObject(activeTabData)
                .frame(width: 130)
                .fixedSize(horizontal: true, vertical: false)
                .background(Color.init(red: 0.15, green: 0.11, blue: 0.06))
            
            ChildrenContent()
                .environmentObject(self.activeTabData)
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
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
