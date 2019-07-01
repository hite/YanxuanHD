//
//  NewArrivalModel.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct NewArrivalModel: Identifiable, Codable {
    
    var id: Int
    
    var colorNum: Int
    
    var name:String
    
    var promTag: String
    
    var productPlace: String
    /// 打折前的价格
    var counterPrice: CGFloat
    /// 打折后的价格
    var retailPrice: CGFloat
    
    var primaryPicUrl: String
    
    var targetUrl: String {
        return "https://you.163.com/item/detail?id=\(self.id)&_stat_referer=index&_stat_area=mod_newItem_item_2"
    }
}
