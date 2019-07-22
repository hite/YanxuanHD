//
//  profileView.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/19.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct ProfileView : View {
    @State var avatar: String = "sidebar-avatar"
    @State var userName: String = "严选用户"
    @State var isMember = false
    @State var memberLevel = 5
    
    var body: some View {
        VStack {
            Group {
                NetworkImage(userData: NetworkImageData(self.avatar))
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding(.top, 15)
                    .padding(.bottom, 24)
                // 超级会员 和 网易 V5 并列
                Text(self.userName)
                    .font(.caption)
                    .foregroundColor(.white)
                
            }.tapAction {
                showLoginWebViewModal("https://you.163.com/user/index")
            }
            
            HStack(spacing: 2.0) {
                if self.isMember {
                    Text("超级会员")
                        .font(.system(size: 14))
                        .foregroundColor(Color.init(red: 0.51, green: 0.45, blue: 0.35))
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .background(Self.gradientGold)
                        .border(Color.clear, width: 2, cornerRadius: 4)
                }
 
                ZStack(alignment: .bottomTrailing) {
                    Image("sidebar-level")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)
                        .background(Color.white)
                    .cornerRadius(4)
                    Text("\(self.memberLevel)")
                        .font(Font.system(size: 10))
                }
                
                Image("sidebar-netease_logo")
                    .frame(width: 18, height: 18, alignment: .center)
                .clipShape(Circle())
                }.onReceive(NotificationCenter.default.publisher(for: .webViewLoadFinish)) { (notif) in
                    if let ret = notif.object as? Dictionary<String, Any?> {
                        if let avatar = ret["avatar"] as? String {
                            self.avatar = avatar
                        }
                        
                        if let isMember = ret["isMember"] as? Bool {
                            self.isMember = isMember
                        }
                        
                        if let memberLevel = ret["memberLevel"] as? Int {
                            self.memberLevel = memberLevel
                        }
                        
                        if let userName = ret["userName"] as? String {
                            self.userName = userName
                        }
                    }
            }
        }
    }
    
    static let golden = Color.init(red: 0.79, green: 0.71, blue: 0.54)

    static let gradientGold = BackgroundColor(startColor: golden, endColor: Color.init(red: 0.99, green: 0.90, blue: 0.76))
}

#if DEBUG
struct profileView_Previews : PreviewProvider {
    static var previews: some View {
        ProfileView(avatar: "sidebar-avatar", userName: "xiangheka2", isMember: true, memberLevel: 6).background(Color.black)
    }
}
#endif
