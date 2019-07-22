//
//  FulisheData.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/2.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class FulisheData: BindableObject {
    let willChange = PassthroughSubject<FulisheData, Never>()
    
    var list: [FulisheItemModel] = [] {
        didSet {
            willChange.send(self)
        }
    }
    var banner: FulisheModel?
    init() {
        
        Networking.fetch(.fulishe) { (r) in
            if let fulisheVO = r as? Dictionary<String, Any>{
                let decoder = JSONDecoder()
                // banner
                if let banner = fulisheVO["banner"] as? Dictionary<String, Any> {
                    do {
                        if let data = jsonToData(jsonDic: banner) {
                            self.banner = try decoder.decode(FulisheModel.self, from: data)
                        } else {
                            print("to jsonToData FulisheVO fails")
                        }
                    } catch let err {
                        fatalError("Couldn't parse \(fulisheVO) as \(FulisheModel.self):\n\(err)")
                    }
                }
                // 下级的数据
                
                if let items = fulisheVO["itemList"] as? [Dictionary<String, Any>] {
                    var list: [FulisheItemModel] = []
                    
                    for item in items {
                        do {
                            if let data = jsonToData(jsonDic: item) {
                                
                                var model = try decoder.decode(FulisheItemModel.self, from: data)
                                
                                let imageUrl = model.showPicUrl + "?imageView&quality=95&thumbnail=130x130"
                                model.showPicUrl = imageUrl
                                list.append(model)
//                                print(item)
                            } else {
                                print("jsonToData itemlist fails")
                            }
                        } catch let err {
                            fatalError("Couldn't parse \(item) as \(FulisheItemModel.self):\n\(err)")
                        }
                        
                    }
                    self.list = list
                }
            }
        }
    }
}
