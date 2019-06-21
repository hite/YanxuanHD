//
//  profileView.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/19.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct ProfileView : View {
    var body: some View {
        VStack {
            Image("sidebar-avatar")
                .frame(width: 60, height: 60)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
                .padding(.top, 15)
            .padding(.bottom, 10)
            // 超级会员 和 网易 V5 并列
            Text("xiangheka")
            .font(.caption)
            .color(.white)
            
            HStack(spacing: 2.0) {
                Text("超级会员")
                .font(.system(size: 12))
                .color(Color.init(red: 0.51, green: 0.45, blue: 0.35))
                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                    .background(Self.gradientGold)
                    .border(Color.clear, width: 2, cornerRadius: 4)
                
                Image("sidebar-level")
                    .frame(width: 24, height: 24, alignment: .center)
                .clipShape(Circle())
                
                Image("sidebar-netease_logo")
                    .frame(width: 18, height: 18, alignment: .center)
                .clipShape(Circle())
            }
        }
    }
    
    static let golden = Color.init(red: 0.79, green: 0.71, blue: 0.54)

    static let gradientGold = BackgroundColor(startColor: golden, endColor: Color.init(red: 0.99, green: 0.90, blue: 0.76))
}

#if DEBUG
struct profileView_Previews : PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
#endif
