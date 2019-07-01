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
                
                HStack(spacing: 10) {
                    RoundInfoView(roundInfo: self.userData.roundInfo!)
                    }.frame(height: 380)
            }
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
