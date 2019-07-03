//
//  WebViewController.swift
//  YanxuanHD
//
//  Created by liang on 2019/6/29.
//  Copyright © 2019 liang. All rights reserved.
//

import Foundation
import UIKit
import WebKit

let kAppHostScheme = "kAppHostScheme"
typealias LoadFinishBlock = ()-> Void

class WebViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler{
    var webView: WKWebView

    var url = "about:blank"
    var onLoadFinish: LoadFinishBlock

    //MARK: scriptmessage
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        let name = message.name
        if(kAppHostScheme.isEqual(name)){
//                        print("name = \(message.body)")
            NotificationCenter.default.post(name: .webViewDataResponse, object: message.body)
        }
    }
    
    init(_ loadFinish: @escaping LoadFinishBlock) {
        let config = WKWebViewConfiguration();
        let userController = WKUserContentController();
        config.userContentController = userController;
        
        self.webView = WKWebView(frame: UIScreen.main.bounds, configuration: config)
        self.onLoadFinish = loadFinish
        super.init(nibName: nil, bundle: nil)
        self.webView.navigationDelegate = self
        userController.add(self, name: kAppHostScheme)
        // apphost
        guard let url = self.jsFileURL("apphost.js") else { return; }
        
        do {
            let code = try String(contentsOf: url, encoding: String.Encoding.utf8)
            let userScript = WKUserScript(source: code, injectionTime: .atDocumentStart, forMainFrameOnly: true)
            userController.addUserScript(userScript)
        } catch {
            print("Parse apphost.js fail \(error)")
        }
        
        guard let fetchRUL = self.jsFileURL("fetch.js") else { return; }
        do {
            let code = try String(contentsOf: fetchRUL, encoding: String.Encoding.utf8)
            let userScript = WKUserScript(source: code, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            userController.addUserScript(userScript)
        } catch {
            print("Parse fetch.js fail \(error)")
        }
    }
    
    func jsFileURL(_ fileName: String) -> URL? {
        return Bundle.main.url(forResource: fileName, withExtension: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit WebViewController")
        
        self.webView.stopLoading()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.webView)
        self.webView.frame = CGRect(x: 0, y: 0, width: 100, height: 10)
        // splash
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash")
        imageView.contentMode = .center
        imageView.backgroundColor = UIColor(red: 1, green: 0x14/0xff, blue: 0x2f/0xff, alpha: 1)
        self.view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
        
        if let url = URL(string: self.url){
            let req = URLRequest(url: url)
            webView.load(req)
        }
        
        NotificationCenter.default.addObserver(forName: .webViewDataRequest, object: nil, queue: nil) { (notif) in
            if let actionName = notif.object as? String {
                self.webView.evaluateJavaScript("window.appHost.fetch('\(actionName)')")
            }
        }
    }
    //MARK:
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
        print("Navigation start")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Load fail,", error)
        self.onLoadFinish()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Did finish")
        webView.evaluateJavaScript("document.title") { (r, err) in
            self.navigationItem.title = (r as! String)
        }
        self.onLoadFinish()
    }
}
