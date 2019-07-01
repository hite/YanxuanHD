//
//  PresentButton.swift
//  YanxuanHD
//
//  Created by liang on 2019/7/1.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct PresentButton: UIViewRepresentable {
    var title: String
    var url: String
    var font: UIFont?
    var color: UIColor?
    
    func makeCoordinator() -> Coordinater {
        Coordinater(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<PresentButton>) -> UIButton {
        let btn = UIButton()
        btn.contentHorizontalAlignment = .trailing
        btn.setTitle(self.title, for: .normal)
        if let color = self.color {
            btn.setTitleColor(color, for: .normal)
        }
        if let font = self.font {
            btn.titleLabel?.font = font
        }
        btn.sizeToFit()
        
        btn.addTarget(context.coordinator, action: #selector(Coordinater.presentURL), for: .touchUpInside)
        return btn
    }
    
    func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<PresentButton>) {
        
    }
    
    class Coordinater: NSObject {
        var presentButton: PresentButton
        
        init(_ pb: PresentButton) {
            self.presentButton = pb
        }
        
        @objc func presentURL(){
            let vc = UIHostingController(rootView: WebView(urlString: self.presentButton.url))
            print("Go to url \(self.presentButton.url)")
            
            guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
                print("fail get root viewController")
                return
            }
            
            rootViewController.present(vc, animated: true, completion: nil)
        }
    }
}

