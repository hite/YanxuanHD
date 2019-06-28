//
//  BackgroundColor.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/19.
//  Copyright © 2019 liang. All rights reserved.
//

import SwiftUI

struct BackgroundColor: View {
    var startColor: Color
    var endColor: Color
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let w = geometry.size.width
                let h = geometry.size.height
                
                path.move(
                    to: CGPoint.zero
                )
                path.addLine(
                    to: CGPoint(
                        x:0,
                        y:h
                    )
                )
                path.addLine(
                    to: CGPoint(
                        x:w,
                        y:h
                    )
                )
                path.addLine(
                    to: CGPoint(
                        x:w,
                        y:0
                    )
                )
                }.fill(LinearGradient(
                    gradient: .init(colors: [self.startColor, self.endColor]),
                    startPoint: .init(x: 1, y: 0.5),
                    endPoint: .init(x: 0, y: 0.5)
                ))
        }
    }
}
#if DEBUG
struct BackgroundColor_Previews : PreviewProvider {
    static var previews: some View {
        BackgroundColor(startColor: Color.green, endColor: Color.red)
    }
}
#endif
