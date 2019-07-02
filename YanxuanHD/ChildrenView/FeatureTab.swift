//
//  FeatureTab.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/20.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct CategorySegmentModel: Identifiable, Hashable{
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

let kSegmentDataSource: [CategorySegmentModel] = [
    CategorySegmentModel("推荐", viewName: "FeatureTab"),
    CategorySegmentModel("居家生活", url: "https://you.163.com/item/list?categoryId=1005000&_stat_area=nav_2"),
    CategorySegmentModel("服饰箱包", url: "https://you.163.com/item/list?categoryId=1010000&_stat_area=nav_3"),
    CategorySegmentModel("美食酒水", url: "https://you.163.com/item/list?categoryId=1005002&_stat_area=nav_4"),
    CategorySegmentModel("护理清洁", url: "https://you.163.com/item/list?categoryId=1013001&_stat_area=nav_5"),
    CategorySegmentModel("母婴亲子", url: "https://you.163.com/item/list?categoryId=1011000&_stat_area=nav_6"),
    CategorySegmentModel("全球特色", url: "https://you.163.com/item/list?categoryId=1019000&_stat_area=nav_9")
]

struct FeatureTab : View {
    @State var currentSegmentModel: CategorySegmentModel = kSegmentDataSource[0]
    
    let singleHeight:CGFloat = 150
    var body: some View {
        VStack() {
            CategorySegment(currentModel: $currentSegmentModel)
            
            if "FeatureTab" == currentSegmentModel.destinationViewName  {
                List() {
                    GeometryReader { geo in
                        BannerScrollView(imageWidth: geo.size.width, imageHeight: self.singleHeight)
                        }
                        .frame(height: 160)
                    
                    OverseaSection(userData: OverseaData())

                    NewArrivalSection(userData: NewArrivalData())

                    FlashSaleSection(userData: FlashSaleData())
                    
                    FulisheSection(userData: FulisheData())
                    
                    VStack {
                        Group{
                            Text("妙得ICP证号：ICP 证浙B2-20160106").color(Color.white)
                            Text("出版物经营许可证：新出发滨字第0132号").color(Color.white)
                            Text("食品经营许可证：JY13301080111719").color(Color.white)
                            Text("单用途商业预付卡备案证：330100AAC0024").color(Color.white)
                        }
                        .font(.caption).padding(.vertical, 2)
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .padding(4)
                        .background(Color(red: 0.25, green: 0.25, blue: 0.25))
                    
                }
                .listStyle(.plain)
                .listRowInsets(EdgeInsets())
            } else {
                WebView(urlString: currentSegmentModel.destinationURL)
            }
        }
        
    }
    
}


#if DEBUG
struct FeatureTab_Previews : PreviewProvider {
    static var previews: some View {
        FeatureTab()
    }
}
#endif
