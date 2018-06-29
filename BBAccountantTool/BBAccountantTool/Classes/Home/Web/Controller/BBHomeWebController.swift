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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navigation_back"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(backClick))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navigation_menu"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(menuClick))
        
    }
    
    @objc private func backClick(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func menuClick(){
//        navigationController?.popViewController(animated: true)
        // 1> 实例化视图
        let v = BBShareView.shareView()
        v.show()
//        v.backgroundColor = UIColor.red
//        view.addSubview(v)
        
        // 2> 显示视图 - 注意闭包的循环引用！
//        v.show { [weak v] (clsName) in
//            print(clsName)
            
            // 展现撰写微博控制器
//            guard let clsName = clsName,
//                let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type
//                else {
//                    v?.removeFromSuperview()
//                    return
//            }
            
//            let vc = cls.init()
//            let nav = UINavigationController(rootViewController: vc)
            
            // 让导航控制器强行更新约束 - 会直接更新所有子视图的约束！
            // 提示：开发中如果发现不希望的布局约束和动画混在一起，应该向前寻找，强制更新约束！
//            nav.view.layoutIfNeeded()
            
//            self.present(nav, animated: true) {
//                v?.removeFromSuperview()
//            }
//        }
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
        if keyPath == "estimatedProgress" {
            progressView.isHidden = wkWebView.estimatedProgress == 1
            progressView.setProgress(Float(wkWebView.estimatedProgress), animated: true)
            print(wkWebView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
    
}

