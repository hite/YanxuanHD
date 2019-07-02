//
//  FlashSaleSection.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct FlashSaleSection : View {
    @State var userData: FlashSaleData
    var body: some View {
        VStack {
            SectionHeader(title:"限时购", desc: "", more: "更多抢购", detailURL: "https://you.163.com/flashSale/index?_stat_area=mod_limit_more&_stat_referer=yanxuanhd")
            
            if self.userData.roundInfo != nil {
                ScrollView(showsHorizontalIndicator: false) {
                    HStack(alignment: .top, spacing: 0) {
                        RoundInfoView(roundInfo: self.userData.roundInfo!)

                        if self.userData.list.count % 2 == 0 {
                            ForEach(0 ..< self.userData.list.count) { idx in
                                if idx % 2 == 0 {
                                    VStack(alignment: .leading, spacing: 0) {
                                        FlashSaleProductShow(model: self.userData.list[idx])
                                        FlashSaleProductShow(model: self.userData.list[idx + (2 - 1)])
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
    
    func legoFor(index: Int, step: Int) -> some View {
        return VStack(alignment: .leading, spacing: 0) {
            FlashSaleProductShow(model: userData.list[index])
            FlashSaleProductShow(model: userData.list[index + (step - 1)])
                .offset(x: 0, y: -1)
        }
    }
}

#if DEBUG
struct FlashSaleSection_Previews : PreviewProvider {
    static var previews: some View {
        FlashSaleSection(userData: FlashSaleData())
    }
}
#endif
