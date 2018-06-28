//
//  BBHomeWebController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/27.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit
import WebKit

class BBHomeWebController: UIViewController {

    var urlString: String = ""
    var titleString: String = ""
    var shareTitle: String = ""
    var shareDscription: String = ""
    
    fileprivate lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: bbScreenWidth, height: 0))
        progressView.trackTintColor = UIColor.white
        progressView.progressTintColor = BBColor(rgbValue: 0x115ACE)
        return progressView
    }()
   
    fileprivate lazy var wkWebView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: bbScreenWidth, height: bbScreenHeight - bbNavBarHeight), configuration: webConfiguration)
        wkWebView.navigationDelegate = self
        wkWebView.load(URLRequest(url: URL(string: urlString)!))
        return wkWebView
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        
        setupWebView()
        view.backgroundColor = UIColor.white
        
    }
    
    private func setupNavigation(){
        navigationItem.title = titleString
    }
    
    private func setupWebView(){
        
        
        
        view.addSubview(wkWebView)
        view.addSubview(progressView)
        wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

    deinit {
        wkWebView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

//MARK:--WKNavigationDelegate
extension BBHomeWebController : WKNavigationDelegate,WKUIDelegate {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"
        {
            progressView.isHidden = wkWebView.estimatedProgress == 1
            progressView.setProgress(Float(wkWebView.estimatedProgress), animated: true)
            print(wkWebView.estimatedProgress)
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
    
}

