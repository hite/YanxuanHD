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
                        .foregroundColor(.gray)
                    
                    if product.newOnShelf {
                        Text("New")
                            .font(Font.footnote)
                            .foregroundColor(kBrandColor)
                            .padding(2)
                    }
                }
                Divider()
                    .frame(width: 100)
                
                Text("\(formatProductPrice(product.floorPrice, fix: 2))元起")
                    .font(Font.system(size: 14 * zoom))
                    .foregroundColor(.gray)
            }
                .offset(x: offsetX, y: offsetY)
            }
            .tapAction {
                showModal("https://you.163.com/item/manufacturer?tagId=\(self.product.id)")
            }
    }

}
