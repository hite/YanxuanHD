//
//  CountDownView.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI
import Foundation

extension Notification.Name {
    static let countdownTimer = Notification.Name("countdownTimer")
}

struct CountDownView : View {
    var leftover: Double = 0
    
    @State var hour = "00"
    @State var minute = "00"
    @State var second = "00"
    
    @State var isTimeout = false
    @State var goneTime = 0
    let brownColor = Color(red: 0.38, green: 0.33, blue: 0.28)

    init(_ leftover: Double) {
        self.leftover = leftover
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            NotificationCenter.default.post(name: .countdownTimer, object: nil)
        }
    }
    
    var body: some View {
        VStack {
            Text(self.isTimeout ? "本场已结束" : "距离结束还剩")
                .foregroundColor(brownColor)
            .font(.headline)
            .fontWeight(.heavy)
                .padding(.bottom, 20)
            
            HStack {
                paper(self.hour)
                
                Text(":")
                    .foregroundColor(brownColor)
                
                paper(self.minute)
                
                Text(":")
                    .foregroundColor(brownColor)
                
                paper(self.second)
                
            }.frame(width: 200)
            }.onReceive(NotificationCenter.default.publisher(for: .countdownTimer)) { output in
                self.goneTime += 1
                
                if Int(self.leftover / 1000) <= self.goneTime {
                    self.isTimeout = true
                    
                    self.hour = "--"
                    self.minute = "--"
                    self.second = "--"
                } else {
                    let counter = Int(self.leftover / 1000) - self.goneTime
                    let hours = Int(counter) / 3600
                    let minutes = Int(counter) / 60 % 60
                    let seconds = Int(counter) % 60
                    
                    let text = String(format: "%02i:%02i:%02i",hours,minutes,seconds)
                    let parts = text.split(separator: ":")
                    self.hour = String(parts[0])
                    self.minute = String(parts[1])
                    self.second = String(parts[2])
                }
        }
    }
    
    func paper(_ num: String) -> some View {
        return Text(num)
            .font(Font.system(size: 18))
            .foregroundColor(Color.white)
            .padding(10)
            .frame(width: 50, height: 50, alignment: .center)
            .background(brownColor)
    }
}

#if DEBUG
struct CountDownView_Previews : PreviewProvider {
    static var previews: some View {
        CountDownView(Double(1561986996874))
    }
}
#endif
