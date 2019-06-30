//
//  OverseaSection.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/29.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct OverseaSection : View {
    
    @State var userData: OverseaData
    
    var body: some View {
        Section {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                
                Text("品牌制造商")
                .font(.title)
                    .padding(.trailing, 10)
                
                Text("工厂直达消费者，剔除品牌溢价")
                .color(Color.gray)
                .font(.caption)
                
                Spacer()
                
                NavigationButton(destination: Text("clicked"), isDetail: true, onTrigger: { () -> Bool in
                    print("What? destination")
                    return true
                }) {
                    Text("更多制造商")
                }
            }.frame(height: 60)
            
            HStack {
                ForEach(self.userData.list) { model in
//                    Text(model.name)
                    NetworkImage(userData: NetworkImageData(model.picUrl))
                }
            }
        }
    }
}

#if DEBUG
struct OverseaSection_Previews : PreviewProvider {
    static var previews: some View {
        OverseaSection(userData: OverseaData())
    }
}
#endif
