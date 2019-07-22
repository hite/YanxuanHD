//
//  SectionHeader.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct SectionHeader : View {
    var title: String
    var desc: String
    var more: String
    var detailURL: String
    
    var body: some View {
        HStack() {
            
            Text(self.title)
                .font(.title)
                .padding(.trailing, 10)
            
            Text(self.desc)
                .foregroundColor(Color.gray)
                .font(.caption)
                .padding(.top, 14)
            
            Spacer()
            
            PresentButton(title: "\(self.more) >", url: self.detailURL, font: .systemFont(ofSize: 14), color: .gray)
                .padding(.top, 10)
        }.frame(height: 60)
    }
}

#if DEBUG
struct SectionHeader_Previews : PreviewProvider {
    static var previews: some View {
        SectionHeader(title: "title", desc: "desc", more: "more", detailURL: "https://news.163.com")
    }
}
#endif
