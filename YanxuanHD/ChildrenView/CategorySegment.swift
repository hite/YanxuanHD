//
//  CategorySegment.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/21.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct CategorySegment : View {
    
    @Binding var currentModel: CategorySegmentModel

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(kSegmentDataSource) {
                    model in
                    VStack {
                        Text(model.name)
                            .bold()
                            .foregroundColor(self.currentModel.id == model.id ? kBrandColor : Color.black)
                            .font(.system(size: 14))
                            .padding(.top, 30)
                        
                        Divider()
                            .background(self.currentModel.id == model.id ? kBrandColor : Color.black)
                            .opacity(0.5)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 5, trailing: 20))
                            .frame(height: 1)
                        .luminanceToAlpha()
                        
                        }
                        .frame(width: 100)
//                        .tag(model)
                        .tapAction {
                            self.currentModel =  model
                    }
            
                }
            }
        }.frame(height: 60)

    }
}

