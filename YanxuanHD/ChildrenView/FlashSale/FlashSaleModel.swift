//
//  FlashSaleModel.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct FlashSaleItemModel: Identifiable, Codable{
    var id: Int {
        return itemId
    }

    var actualPrice: CGFloat
    
    var currentSellVolume: Int
    
    var itemId: Int
    
    var itemName: String
    
    var primaryPicUrl: String
    
    var retailPrice: CGFloat
    
    var simpleDesc: String
    
    var soldoutFlag: Int
    
    var totalSellVolume: Int
    
}

struct FlashSaleModel: Codable {

    var currentTime: Double
    
    var leftTime: Double
    
    var startTime: Double
    
    var backgroundImageUrl: String {
        return "https://yanxuan.nosdn.127.net/c9aeb62a3f79123d793d8c49b6698b09.jpg"
    }
    var viewAllUrl: String {
        return "https://you.163.com/flashSale/index?_stat_area=mod_limit_item_0&_stat_referer=index"
    }
}
