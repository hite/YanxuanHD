//
//  SidebarMenuData.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/19.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import SwiftUI

struct SidebarMenuItem: Hashable, Codable, Identifiable {
    
    var id: Int
    
    var title: String
    
    var imageName:String
    
    var isSpacer: Bool
    
    var childViewName: String
    
    var url: String
    
}

