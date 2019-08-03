//
//  FlashSaleSection.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct FlashSaleSection : View {
    @EnvironmentObject var userData: FlashSaleData
    var body: some View {
        VStack {
            SectionHeader(title:"限时购", desc: "", more: "更多抢购", detailURL: "https://you.163.com/flashSale/index?_stat_area=mod_limit_more&_stat_referer=yanxuanhd")
            
            if self.userData.roundInfo != nil {
                ScrollView() {
                    HStack(alignment: .top, spacing: 0) {
                        RoundInfoView(roundInfo: self.userData.roundInfo!)

                        if self.userData.list.count > 0 {
                            if self.userData.list.count % 2 == 0 {
                                piece(0)
                            }
                            if self.userData.list.count % 4 == 0 {
                                piece(2)
                            }
                            if self.userData.list.count % 6 == 0 {
                                piece(4)
                            }
                        } else {
                            Text("数据格式错误，返回了个数是奇数")
                        }
                    }
                }.frame(height: 400)
            }
        }
    }
    
    func piece(_ index: Int) -> some View{
        return VStack(alignment: .leading, spacing: 0) {
            FlashSaleProductShow(model: self.userData.list[index])
            FlashSaleProductShow(model: self.userData.list[index + (2 - 1)])
                .offset(x: 0, y: -1)
        }
    }

}

#if DEBUG
struct FlashSaleSection_Previews : PreviewProvider {
    static var previews: some View {
        FlashSaleSection().environmentObject(FlashSaleData())
    }
}
#endif
