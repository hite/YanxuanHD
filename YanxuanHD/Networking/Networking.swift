//
//  Networking.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation

enum NetworkDataType: String {
    
    case banners
    
    case fulishe
    
    case oversea
    
    case newarrival
    
    case topsale
    
    case flashsale
    
    case userinfo
}

final class Networking {
    static func fetch(_ dataType: NetworkDataType, completion: @escaping (Any?) -> Void) {
        NotificationCenter.default.post(name: .webViewDataRequest, object: dataType.rawValue);
        NotificationCenter.default.addObserver(forName: .webViewDataResponse, object: nil, queue: nil) { (notif) in
            if let ret = notif.object as? Dictionary<String, Any?> {
                
                if let action = ret["action"] as? String {
                    if action == dataType.rawValue {
                        if let result = ret["param"] {
                            completion(result)
                        }
                    }
                }
            }
        }
    }
}
