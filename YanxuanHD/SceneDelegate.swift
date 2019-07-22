//
//  SceneDelegate.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/19.
//  Copyright © 2019 liang. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    // 用 WebView 来充当数据源
    var networking: UIWindow?
    private var keyWindow: UIWindow? // 当前活动的窗口

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Use a UIHostingController as window root view controller
        if let windowScene = scene as? UIWindowScene {

            let splashVC = WebViewController() {
                let window = UIWindow(windowScene: windowScene)
                let vc = UIHostingController(rootView: ContentView())
                window.rootViewController = vc
                self.window = window
                window.makeKeyAndVisible()
            }
            // 先显示 splash 界面，结束之后，显示 ContentView
            let window = UIWindow(windowScene: windowScene)
            splashVC.url = "https://you.163.com"
            window.rootViewController = splashVC
            self.networking = window
            window.makeKeyAndVisible()
        }
        
        NotificationCenter.default.addObserver(forName: .presentModalWindow, object: nil, queue: nil) { (notif) in
            if let url = notif.object as? String {
                DispatchQueue.main.async {
                    self.presentURL(url)
                }
            }
        }
        NotificationCenter.default.addObserver(forName: .presentLoginWebViewWindow, object: nil, queue: nil) { (notif) in
            if let url = notif.object as? String {
                DispatchQueue.main.async {
                    self.presentLoginWebView(url)
                }
            }
        }
//            .post(name: .presentModalWindow, object: "https://you.163.com/item/manufacturer?tagId=\(self.product.id)")
    }
    
    func presentLoginWebView(_ url: String){
        //其他页面执行 document.querySelector 出现脚本错误，不会返回
        let jscode = """
        var ret = {
            userName : userInfo.nickname,
            avatar: document.querySelector('.m-userInfo .info .infoWrap .avatar img').src,
            isMember: userInfo.membershipOn,
            memberLevel: userInfo.memberLevel
        }
        """
        let vc = UIHostingController(rootView: WebView(urlString: url, loadFinishEvaluated: jscode))
        print("Go to url \(url)")
        
        guard let rootViewController = keyWindow?.rootViewController else {
            print("fail get root viewController")
            return
        }
        
        rootViewController.present(vc, animated: true, completion: nil)
    }
    func presentURL(_ url: String){
        let vc = UIHostingController(rootView: WebView(urlString: url))
        print("Go to url \(url)")
        
        guard let rootViewController = keyWindow?.rootViewController else {
            print("fail get root viewController")
            return
        }
        
        rootViewController.present(vc, animated: true, completion: nil)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        if let windowScene = scene as? UIWindowScene {
            self.keyWindow = windowScene.windows.first
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

