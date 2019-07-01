//
//  Data.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/19.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import UIKit


let sidebarMenuItems: [SidebarMenuItem] = load("sidebarMenus.json")

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch let err{
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(err)")
    }
}

func jsonToData(jsonDic:Dictionary<String, Any>) -> Data? {
    
    if (!JSONSerialization.isValidJSONObject(jsonDic)) {
        
        print("is not a valid json object")
        
        return nil
        
    }
    
    //利用自带的json库转换成Data
    
    //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
    
    let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
    
    return data
    
}


func formatProductPrice(_ price: CGFloat, fix: Int = 0) -> String {
    
    let pricetxt = String(format: "%.\(fix)f", price)
    return pricetxt
}

func showModal(_ url: String) {
    NotificationCenter.default.post(name: .presentModalWindow, object: url)
}


