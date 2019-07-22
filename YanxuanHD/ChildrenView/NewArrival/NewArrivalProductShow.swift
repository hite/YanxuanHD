//
//  NewArrivalProductShow.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct NewArrivalProductShow : View {
    var model: NewArrivalModel
    
    let golden = Color.init(red: 0.73, green: 0.67, blue: 0.54)
    var body: some View {
        VStack {
            ZStack {
                NetworkImage(userData: NetworkImageData(model.primaryPicUrl))
                .background(Color(red: 0xf4/0xff, green: 0xf4/0xff, blue: 0xf4/0xff))
                
                if self.cornerLabel(model) != nil {
                    Text(self.cornerLabel(model)!)
                    .font(.caption)
                    .foregroundColor(golden)
                        .padding(4)
                    .border(golden, width: 1)
                    .position(x: 50, y: 30)
                }
            }.tapAction {
                showModal(self.model.targetUrl)
            }.padding(.bottom, 10)
            
            if model.promTag.count > 0 {
                Text(model.promTag)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color(red: 0.89, green: 0.41, blue: 0.27))
            } else {
                Text("model.promTag")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(4)
            }
            
            Text(model.name)
                .font(.headline)
                .padding(.bottom, 1)
                .padding(.top, 10)
            HStack {
                Text("￥\(formatProductPrice(model.retailPrice))")
                    .font(.body)
                .foregroundColor(kBrandColor)
                if (model.counterPrice != 0 && model.retailPrice != model.counterPrice) {
                    Text("￥\(formatProductPrice(model.counterPrice))")
                        .font(.body)
                }
            }
            
            Spacer()
        }
    }
    
    func cornerLabel(_ model:NewArrivalModel) -> String? {
        if model.colorNum > 1 {
            return "\(model.colorNum)色可选"
        } else if (model.productPlace.count > 1){
            return model.productPlace
        } else {
            return nil
        }
        
    }
}

#if DEBUG
struct NewArrivalProductShow_Previews : PreviewProvider {
    static var previews: some View {
        NewArrivalProductShow(model: NewArrivalModel(id: 102, colorNum: 3, name: "明霞 男士运动休闲凉鞋", promTag: "7月皇册特惠", productPlace: "好价购", counterPrice: 169, retailPrice: 144, primaryPicUrl: "https://yanxuan.nosdn.127.net/5c2d59dcc6843ad243492a3e1ac9c9b9.png"))
    }
}
#endif
