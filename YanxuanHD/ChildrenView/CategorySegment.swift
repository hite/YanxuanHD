//
//  CategorySegment.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/21.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct CategorySegmentModel: Identifiable{
    var id: String
    
    var destinationViewName: String?
    var name: String
    var destinationURL: String?
    
    init(_ name: String, viewName: String?, url: String?) {
        self.name = name
        self.destinationViewName = viewName
        self.destinationURL = url
        // name 作为 key
        self.id = name
    }
    
    init(_ name: String, viewName: String) {
        self.init(name, viewName: viewName, url: nil)
    }
    init(_ name: String, url: String) {
        self.init(name, viewName: nil, url: url)
    }
}

struct CategorySegment : View {
    var selectedIndex = 0
    
    var dataSource: [CategorySegmentModel] = [
        CategorySegmentModel("推荐", viewName: "FeatureTab"),
        CategorySegmentModel("居家生活", url: "https://you.163.com/item/list?categoryId=1005000&_stat_area=nav_2"),
        CategorySegmentModel("服饰箱包", url: "https://you.163.com/item/list?categoryId=1010000&_stat_area=nav_3"),
        CategorySegmentModel("美食酒水", url: "https://you.163.com/item/list?categoryId=1005002&_stat_area=nav_4"),
        CategorySegmentModel("服饰箱包", url: "https://you.163.com/item/list?categoryId=1013001&_stat_area=nav_5"),
        CategorySegmentModel("母婴亲子", url: "https://you.163.com/item/list?categoryId=1011000&_stat_area=nav_6"),
        CategorySegmentModel("全球特色", url: "https://you.163.com/item/list?categoryId=1019000&_stat_area=nav_9")
    ]
    var body: some View {
         VStack {
            ScrollView(showsHorizontalIndicator: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.dataSource) { model in
                        VStack {
                            Text(model.name)
                                .bold()
                                //                            .font(14)
                                .padding(.top, 10)
                            
                            Divider()
                                .background(Color.yellow)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 5, trailing: 20))
                                .frame(height: 3)
                            }
                            .frame(width: 110)
                    }
                }
            }
            .frame(height: 40)

        }
    }
}

#if DEBUG
struct CategorySegment_Previews : PreviewProvider {
    static var previews: some View {
        CategorySegment()
    }
}
#endif
