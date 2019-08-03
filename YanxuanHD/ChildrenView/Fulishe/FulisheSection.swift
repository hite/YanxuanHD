//
//  FulisheSection.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/2.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct FulisheSection : View {
    @EnvironmentObject  var userData: FulisheData
    
    var body: some View {
        VStack {
            SectionHeader(title:"福利社", desc: "", more: "查看全部福利 ", detailURL: "https://you.163.com/saleCenter/index_stat_referer=yanxuanhd")
            
            ScrollView() {
                HStack(alignment: .top, spacing: 0) {
                    if userData.banner != nil {
                        NetworkImage().environmentObject(NetworkImageData(userData.banner!.picUrl))
                    }
                    // ForEach 循环，会导致编译时间过长，而导致无法编译，目前的 SwiftUI 设计缺陷
                    // beta5 之后，不能使用原先的循环的方式来遍历了，只好分拆为更确定的 3 个数量
                    if self.userData.list.count > 0 && self.userData.list.count % 2 == 0 {
                        renderPieceAt(0)
                    }
                    if self.userData.list.count > 0 && self.userData.list.count % 4 == 0 {
                        renderPieceAt(2)
                    }
                    if self.userData.list.count > 0 && self.userData.list.count % 6 == 0 {
                        renderPieceAt(4)
                    }
                }
            }.frame(height: 400)
        }
    }
    
    func renderPieceAt(_ idx: Int) -> some View {
        return VStack {
            FulisheProductShow(model: self.userData.list[idx])
            FulisheProductShow(model: self.userData.list[idx + 1])
        }
    }
}

#if DEBUG
struct FulisheSection_Previews : PreviewProvider {
    static var previews: some View {
        FulisheSection().environmentObject(FulisheData())
    }
}
#endif
