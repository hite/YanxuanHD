//
//  NetworkImage.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/30.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct NetworkImage : View {
    @State var userData: NetworkImageData

    var body: some View {
        Group {
            if self.userData.imgData == nil{
                Image(systemName: "slowmo")
            } else {
                Image(uiImage: self.userData.imgData!)
            }
        }
    }
}

//#if DEBUG
//struct NetworkImage_Previews : PreviewProvider {
//    static var previews: some View {
//        NetworkImage(userData: NetworkImageData("https://yanxuan.nosdn.127.net/027d936f4ce88772a57cb993772c82d9.png"))
//    }
//}
//#endif
