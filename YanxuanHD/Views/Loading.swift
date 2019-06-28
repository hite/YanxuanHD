//
//  Loading.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/28.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct Loading : View {
    var progress: Double = 0
    var body: some View {
        HStack {
            Text("正在加载...\(Int(self.progress * 100))%")
            .color(Color.white)
            .font(.title)
        }
            .frame(minWidth:0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.25))
    }
}

#if DEBUG
struct Loading_Previews : PreviewProvider {
    static var previews: some View {
        Loading(progress: 0.34)
    }
}
#endif
