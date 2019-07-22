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
    let activeTabData = ActiveTabData()
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text("what")
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
