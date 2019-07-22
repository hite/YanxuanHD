//
//  NewArrivalSection.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct NewArrivalSection : View {
    
    @State var userData: NewArrivalData
    
    var body: some View {
        VStack {
            SectionHeader(title:"新品首发", desc: "为你寻觅世间好物", more: "更多新品", detailURL: "https://you.163.com/item/newItem?_stat_area=newItem_link&_stat_referer=yanxuanhd")

            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(self.userData.list) { product in
                        NewArrivalProductShow(model: product)
                    }
                }
            }
                .frame(height: 400)
        }
    }
}

#if DEBUG
struct NewArrivalSection_Previews : PreviewProvider {
    static var previews: some View {
        NewArrivalSection(userData: NewArrivalData())
    }
}
#endif
