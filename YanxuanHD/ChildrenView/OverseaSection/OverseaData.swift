//
//  OverseaData.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/29.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class OverseaData: ObservableObject, Identifiable {

    @Published var list: [OverseaModel] = []
    
    init() {
        
        Networking.fetch(.oversea) { (r) in
            var list: [OverseaModel] = []
            if let items = r as? [Dictionary<String, Any>]{
                for item in items {
                    list.append(OverseaModel(from: item))
//                    print(item)
                }
                
                self.list = list
            }
        }

    }
}
