//
//  NewArrivalData.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class NewArrivalData: BindableObject {
    let didChange = PassthroughSubject<NewArrivalData, Never>()
    
    var list: [NewArrivalModel] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        var list: [NewArrivalModel] = []
        
        Networking.fetch(.newarrival) { (r) in
            if let items = r as? [Dictionary<String, Any>]{
                for item in items {
                    
                    do {
                        let decoder = JSONDecoder()
                        if let data = jsonToData(jsonDic: item) {

                            var model = try decoder.decode(NewArrivalModel.self, from: data)

                            let imageUrl = model.primaryPicUrl + "?imageView&quality=95&thumbnail=265x265"
                            model.primaryPicUrl = imageUrl
                            list.append(model)
                            print(item)
                        }
                    } catch let err {
                        fatalError("Couldn't parse \(item) as \(NewArrivalModel.self):\n\(err)")
                    }
                    
                    
//                    var model = NewArrivalModel(from: item)
//                    let imageUrl = model.scenePicUrl + "?imageView&quality=95&thumbnail=265x265"
//                    model.scenePicUrl = imageUrl
//                    list.append(model)
//                    print(item)
                }
                
                self.list = list
            }
        }
        
    }
}
