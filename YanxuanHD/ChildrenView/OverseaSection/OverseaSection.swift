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
            HStack() {
                
                Text("品牌制造商")
                .font(.title)
                    .padding(.trailing, 10)
                
                Text("工厂直达消费者，剔除品牌溢价")
                .color(Color.gray)
                .font(.caption)
                    .padding(.top, 14)
                
                Spacer()
                
                PresentButton(title: "更多制造商 >", url: "https://news.163.com", font: .systemFont(ofSize: 14), color: .gray)
                    .padding(.top, 10)
            }.frame(height: 60)
            
            if self.userData.list.count == 4 {
                
                ScrollView(showsHorizontalIndicator: false) {
                    
                    HStack {
                        OverseaProductShow(product: self.userData.list[0], offsetX: 0, offsetY: -60)
                        OverseaProductShow(product: self.userData.list[1], offsetX: 0, offsetY: -60)
                        VStack {
                            OverseaProductShow(product: self.userData.list[2], offsetX: -70, offsetY: 0, zoom: 0.6)
                            OverseaProductShow(product: self.userData.list[3], offsetX: -70, offsetY: 0, zoom: 0.6)
                        }
                    }
                }.frame(height: 320)
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
