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
        // 1> 实例化视图
        let v = BBShareView.shareView()
        v.show {(clsName) in
            
            if clsName! == "微信" {
                MBProgressHUD.showTitle("微信分享，账号还没有", to: self.view)
            }
            
            if clsName! == "朋友圈" {
                MBProgressHUD.showTitle("朋友圈分享，账号还没有", to: self.view)
            }
            
            if clsName! == "复制链接" {
                self.pasteBoard(str: self.urlString)
            }
            
            if clsName! == "保存图片" {
               TProgressHUD.show()
                self.wkWebView.DDGContentScreenShot { (image) in
                    TProgressHUD.hide()
                    UIImageWriteToSavedPhotosAlbum(image!, self, #selector(self.saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
                }
            }
            
            if clsName! == "复制链接" {
                self.pasteBoard(str: self.urlString)
            }
            
            
            
            v.removeFromSuperview()
        }
        
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
    
    /// 保存长截图
    ///
    /// - Parameters:
    ///   - image: 返回的图片
    ///   - error: 错误信息
    ///   - contextInfo: 描述
    @objc private func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        var showMessage = ""
        if error != nil{
            showMessage = "保存失败"
        }else{
            showMessage = "保存成功"
        }
        MBProgressHUD.showTitle(showMessage, to: view)
    }
    
    /// 复制到剪切板
    ///
    /// - Parameter str: 需要复制的链接
    private func pasteBoard(str:String) {
        //就这两句话就实现了
        let paste = UIPasteboard.general
        paste.string = str
        MBProgressHUD.showTitle("链接已复制", to: view)
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

