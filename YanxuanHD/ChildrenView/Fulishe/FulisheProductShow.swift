//
//  FulisheProductShow.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/2.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI


struct FulisheProductShow : View {
    var model: FulisheItemModel
    
    let lightRed = Color(red: 1.00, green: 0.90, blue: 0.90)
    let lightGray = Color(red: 0.6, green: 0.6, blue: 0.6)
    var body: some View {
        HStack {
            ZStack(alignment: .bottomTrailing) {
                NetworkImage(userData: NetworkImageData(model.showPicUrl))
                .background(Color(red: 0.99, green: 0.98, blue: 0.96))
                .padding(20)

                Text("\(formatProductPrice(model.disCount))折")
                .fontWeight(.heavy)
                .color(Color.white)
                    .frame(width: 40, height: 40)
                .background(Color(red: 0.97, green: 0.55, blue: 0.20))
                    .clipShape(Circle())
                .shadow(radius: 4)
                .offset(x: -10, y: -10)
            }
                .tapAction {
                    showModal(self.model.detailUrl)
            }

            VStack(alignment: .leading) {
                Text(model.name)
                    .fontWeight(.heavy)
                    .color(Color.black)
                    .font(Font.system(size: 14))
                    .padding([.top], 18)
                    .padding([.bottom], 2)
                    .lineLimit(2)

                HStack(alignment: .lastTextBaseline, spacing: 0) {
                    Text("限时价")
                        .font(.caption)
                        .color(kBrandColor)

                    Text("￥\(formatProductPrice(model.retailPrice))")
                        .font(.subheadline)
                        .color(kBrandColor)
                }.padding(0)

                Text("￥\(formatProductPrice(model.counterPrice))")
                    .font(.caption)
                    .color(lightGray)
                    .strikethrough()
                    .padding(.leading, 10)

                Button(action: {
                    showModal(self.model.detailUrl)
                }) {
                    Text("立即抢购")
                        .font(.caption)
                        .color(Color.white)
                        .padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 20))
                        .cornerRadius(4)
                        .background(kBrandColor)
                }
                }.frame(width: 200)
        }
    }
}

#if DEBUG
struct FulisheProductShow_Previews : PreviewProvider {
    static let model = FulisheItemModel(id: 1234, counterPrice: 145, retailPrice: 162, disCount: 7.8, name: "提花冰丝席三件套 可折叠凉席", showPicUrl: "https://yanxuan.nosdn.127.net/0f06898140d349b7e466cc5b41265685.png?quality=95&thumbnail=130x130&imageView")
    static var previews: some View {
        VStack(alignment: .leading, spacing: 0) {
            FulisheProductShow(model: model)
            FulisheProductShow(model: model)
                .offset(x:0, y: -1)
            //            Spacer()
        }
        
    }
}
#endif
