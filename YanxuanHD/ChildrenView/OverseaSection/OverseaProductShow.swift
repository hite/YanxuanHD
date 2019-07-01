//
//  OverseaProductShow.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI
import Foundation

struct OverseaProductShow : View {
    var product: OverseaModel
    var offsetX: CGFloat
    var offsetY: CGFloat
    
    // 控制字号
    var zoom: CGFloat =  1
    
    var body: some View {
        ZStack {
            NetworkImage(userData: NetworkImageData(product.picUrl))
            VStack {
                HStack {
                    Text(product.name)
                        .font(Font.system(size: 24 * zoom))
                        .color(.gray)
                    
                    if product.newOnShelf {
                        Text("New")
                            .font(Font.footnote)
                            .color(kBrandColor)
                            .padding(2)
                    }
                }
                Divider()
                    .frame(width: 100)
                
                Text(self.formatPrice(product.floorPrice))
                    .font(Font.system(size: 14 * zoom))
                    .color(.gray)
            }
                .offset(x: offsetX, y: offsetY)
            }
            .tapAction {
                NotificationCenter.default.post(name: .presentModalWindow, object: "https://you.163.com/item/manufacturer?tagId=\(self.product.id)")
            }
    }
    
    func formatPrice(_ price: CGFloat) -> String {
        
        let pricetxt = String(format: "%.2f", price)
        return "\(pricetxt)元起"
    }
}
