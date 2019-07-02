//
//  FulisheModel.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/2.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct FulisheModel: Codable {
    var id: Int
    
    var picUrl: String
    
    var targetUrl: String
}


struct FulisheItemModel: Identifiable, Codable {
    var id: Int
    
    var counterPrice: CGFloat
    var retailPrice: CGFloat
    
    var disCount: CGFloat
    
    var name: String
    
    var showPicUrl: String
    
    var detailUrl: String {
        return "https://you.163.com/item/detail?id=\(id)"
    }
}

