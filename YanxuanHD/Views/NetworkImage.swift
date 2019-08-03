//
//  NetworkImage.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/30.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct NetworkImage : View {
    @EnvironmentObject var userData: NetworkImageData

    var body: some View {
        Group {
            if self.userData.imgData == nil{
                Image(systemName: "slowmo")
            } else {
                Image(uiImage: self.userData.imgData!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#if DEBUG
struct NetworkImage_Previews : PreviewProvider {
    static var previews: some View {
        NetworkImage().environmentObject(NetworkImageData("https://gaoqing.fm/uploads/2019/33940d11dfaa.jpg"))
            .frame(width: 60, height: 60)
            .clipShape(Circle())
//            .overlay(Circle().stroke(Color.white, lineWidth: 4))
//            .shadow(radius: 10)
    }
}
#endif
