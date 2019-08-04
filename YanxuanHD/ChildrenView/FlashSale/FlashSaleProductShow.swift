//
//  FlashSaleProductShow.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/2.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct FlashSaleProductShow : View {
    var model: FlashSaleItemModel
    
    let lightRed = Color(red: 1.00, green: 0.90, blue: 0.90)
    let lightGray = Color(red: 0.6, green: 0.6, blue: 0.6)
    var body: some View {
        HStack {
            NetworkImage().environmentObject(NetworkImageData(model.primaryPicUrl))
                .onTapGesture {
                    showModal(self.model.detailUrl)
            }
            
            VStack(alignment: .leading) {
                Text(model.itemName)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    .font(Font.system(size: 16))
                    .padding([.top], 8)
                .padding([.bottom], 2)
                
                Text(model.simpleDesc)
                    .foregroundColor(lightGray)
                    .font(Font.system(size: 14))
                    .bold()
                    .padding([.bottom], 2)
                .padding([.top], 0)
                
                HStack {
                    ZStack(alignment: .topLeading) {
                        Rectangle()
                            .fill(Color.white)
                            .border(lightRed, width: 1)
                            .cornerRadius(10)
                            .frame(width: 152, height: 10)
                        
                        Rectangle()
                            .fill(lightRed)
                            .border(lightRed, width: 1)
                            .cornerRadius(10)
                            .frame(width: self.progress(model, width: 152), height: 10)
                    }
                    
                    Text("还剩\(model.totalSellVolume - model.currentSellVolume)件")
                    .foregroundColor(lightGray)
                    .font(Font.system(size: 14))
                    .padding(.leading, 5)
                }
                
                HStack(alignment: .lastTextBaseline, spacing: 0) {
                    Text("限时价")
                    .font(.body)
                    .foregroundColor(kBrandColor)
                    
                    Text("￥\(formatProductPrice(model.actualPrice))")
                    .font(.title)
                    .foregroundColor(kBrandColor)
                    
                    Text("￥\(formatProductPrice(model.retailPrice))")
                        .font(.body)
                        .foregroundColor(lightGray)
                        .strikethrough()
                    .padding(.leading, 10)
                }.padding(0)
                
                Button(action: {
                    showModal(self.model.detailUrl)
                }) {
                    Text("立即抢购")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 20))
                        .cornerRadius(4)
                    .background(kBrandColor)
                }
            }.frame(width: 255)
        }.padding(.bottom, 10)
            .border(Color(red: 0.94, green: 0.93, blue: 0.89), width: 1)
    }
    
    func progress(_ model: FlashSaleItemModel, width: CGFloat) -> CGFloat {
        let factor = CGFloat(model.currentSellVolume) / CGFloat(model.totalSellVolume)
        print("sell progress = \(factor)")
        return width * CGFloat(factor)
    }
}

#if DEBUG
struct FlashSaleProductShow_Previews : PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 0) {
            FlashSaleProductShow(model: FlashSaleItemModel(actualPrice: 162, currentSellVolume: 80, itemId: 1234, itemName: "智能马桶盖", primaryPicUrl: "https://yanxuan.nosdn.127.net/4f43f69ece3312fcd0b032c949c7c71b.png?imageView&thumbnail=180x180&quality=95", retailPrice: 145, simpleDesc: "bingdian tejia", soldoutFlag: 0, totalSellVolume: 100))
            FlashSaleProductShow(model: FlashSaleItemModel(actualPrice: 162, currentSellVolume: 99, itemId: 1234, itemName: "智能马桶盖", primaryPicUrl: "https://yanxuan.nosdn.127.net/4f43f69ece3312fcd0b032c949c7c71b.png?imageView&thumbnail=180x180&quality=95", retailPrice: 145, simpleDesc: "bingdian tejia", soldoutFlag: 0, totalSellVolume: 100))
                .offset(x:0, y: -1)
//            Spacer()
        }
        
    }
}
#endif
