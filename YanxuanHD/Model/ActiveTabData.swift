//
//  ActiveTabData.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/27.
//  Copyright © 2019 liang. All rights reserved.
//


import Combine
import SwiftUI

final class ActiveTabData: ObservableObject, Identifiable {
    @Published var activeMenuItem = sidebarMenuItems[0]
}
