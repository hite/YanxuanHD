//
//  OverseaModel.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/29.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

var kIdSeed = 1000
struct OverseaModel: Identifiable {
    
    var id: Int
    
    var floorPrice: CGFloat
    
    var name:String
    
    var newOnShelf: Bool
    
    var picUrl: String
    
    init(from: Dictionary<String, Any>) {
        kIdSeed += 1
        self.id = from["id"] as? Int ?? kIdSeed
        self.floorPrice = from["floorPrice"] as! CGFloat
        self.picUrl = from["picUrl"] as! String
        self.name = from["name"] as! String
        self.newOnShelf = from["newOnShelf"] as! Bool
    }
}
