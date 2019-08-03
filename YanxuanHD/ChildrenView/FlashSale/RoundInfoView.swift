//
//  RoundInfoView.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct RoundInfoView : View {
    var roundInfo: FlashSaleModel
    let brownColor = Color(red: 0.38, green: 0.33, blue: 0.28)
    var body: some View {
        ZStack {
            NetworkImage().environmentObject(NetworkImageData(roundInfo.backgroundImageUrl))
            VStack {
                Text("\(self.hourClock(roundInfo.startTime))点场")
                .font(.title)
                    .foregroundColor(brownColor)

                Divider()
                    .frame(width: 15)
                .background(brownColor)

                CountDownView(roundInfo.leftTime)
                .padding(.bottom, 60)
                
                Button(action: {
                    showModal(self.roundInfo.viewAllUrl)
                }) {
                    Text("查看全部 > ")
                    .font(.headline)
                        .foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                    .background(Color(red: 0.66, green: 0.58, blue: 0.43))
                    .cornerRadius(30)
                }
            }
        }
    }
    
    func hourClock(_ startTime: Double) -> Int {
        let date = Date(timeIntervalSince1970: startTime)
        let calendar = Calendar.current // or e.g. Calendar(identifier: .persian)
        
        let hour = calendar.component(.hour, from: date)
        return hour + 8
    }
}

#if DEBUG
struct RoundInfoView_Previews : PreviewProvider {
    static var previews: some View {
        RoundInfoView(roundInfo: FlashSaleModel(currentTime: 99000, leftTime: 2300, startTime: 1000))
    }
}
#endif
