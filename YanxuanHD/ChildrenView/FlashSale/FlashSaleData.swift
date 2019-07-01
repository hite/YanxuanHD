//
//  FlashSaleData.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class FlashSaleData: BindableObject {
    let didChange = PassthroughSubject<FlashSaleData, Never>()
    
    var list: [FlashSaleItemModel] = [] {
        didSet {
            didChange.send(self)
        }
    }
    var roundInfo: FlashSaleModel?
    init() {
        
        Networking.fetch(.flashsale) { (r) in
            if let flashSaleVO = r as? Dictionary<String, Any>{
                let decoder = JSONDecoder()
                // 然后是本场数据
                do {
                    if let data = jsonToData(jsonDic: flashSaleVO) {
                        self.roundInfo = try decoder.decode(FlashSaleModel.self, from: data)
                    } else {
                        print("to jsonToData flashSaleVO fails")
                    }
                } catch let err {
                    fatalError("Couldn't parse \(flashSaleVO) as \(FlashSaleModel.self):\n\(err)")
                }
                // 下级的数据
                
                if let items = flashSaleVO["itemList"] as? [Dictionary<String, Any>] {
                    var list: [FlashSaleItemModel] = []
  
                    for item in items {
                        do {
                            if let data = jsonToData(jsonDic: item) {
                                
                                var model = try decoder.decode(FlashSaleItemModel.self, from: data)
                                
                                let imageUrl = model.primaryPicUrl + "?imageView&quality=95&thumbnail=180x180"
                                model.primaryPicUrl = imageUrl
                                list.append(model)
                                print(item)
                            } else {
                                print("jsonToData itemlist fails")
                            }
                        } catch let err {
                            fatalError("Couldn't parse \(item) as \(FlashSaleItemModel.self):\n\(err)")
                        }
                        
                    }
                    self.list = list
                }
            }
        }
    }
}
