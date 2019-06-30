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

final class OverseaData: BindableObject {
    let didChange = PassthroughSubject<OverseaData, Never>()
    
    var list: [OverseaModel] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        var list: [OverseaModel] = []
        
        NotificationCenter.default.post(name: .webViewDataRequest, object: "oversea");
        NotificationCenter.default.addObserver(forName: .webViewDataResponse, object: nil, queue: nil) { (notif) in
            if let ret = notif.object as? Dictionary<String, Any?> {
                print("webViewDataResponse = \(String(describing: ret))")
                if let action = ret["action"] as? String {
                    if action == "oversea" {
                        if let items = ret["param"] as? [Dictionary<String, Any>]{
                            for item in items {
                                list.append(OverseaModel(from: item))
                                print(item)
                            }
                            
                            self.list = list
                        }
                    }
                }
            }
        }
    }
}
