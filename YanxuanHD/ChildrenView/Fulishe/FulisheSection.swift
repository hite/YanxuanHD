//
//  FulisheSection.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/2.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct FulisheSection : View {
    @State var userData: FulisheData
    
    var body: some View {
        VStack {
            SectionHeader(title:"福利社", desc: "", more: "查看全部福利 ", detailURL: "https://you.163.com/saleCenter/index_stat_referer=yanxuanhd")
            
            ScrollView() {
                HStack(alignment: .top, spacing: 0) {
                    if userData.banner != nil {
                        NetworkImage(userData: NetworkImageData(userData.banner!.picUrl))
                    }
                    
                    
                    if self.userData.list.count > 0 && self.userData.list.count % 2 == 0 {
                        ForEach(0 ..< self.userData.list.count) { idx in
                            if idx % 2 == 0 {
                                VStack(alignment: .leading, spacing: 0) {
                                    FulisheProductShow(model: self.userData.list[idx])
                                    FulisheProductShow(model: self.userData.list[idx + (2 - 1)])
                                        .offset(x: 0, y: -1)
                                }
                            }
                        }
                    } else {
                        Text("数据格式错误，返回了个数是奇数")
                    }
                }
            }.frame(height: 400)
        }
    }
}

#if DEBUG
struct FulisheSection_Previews : PreviewProvider {
    static var previews: some View {
        FulisheSection(userData: FulisheData())
    }
}
#endif
