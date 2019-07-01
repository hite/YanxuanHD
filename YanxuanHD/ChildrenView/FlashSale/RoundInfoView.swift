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
    
    var body: some View {
        ZStack {
            NetworkImage(userData: NetworkImageData(roundInfo.backgroundImageUrl))
            VStack {
                Text("\(self.hourClock(roundInfo.startTime))点场")
                .font(.title)
                .color(.gray)

                Divider().frame(width: 15)

                CountDownView(roundInfo.leftTime)
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
