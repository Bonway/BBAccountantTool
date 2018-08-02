//
//  BBNewsDetailController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/17.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit
import WebKit
class BBNewsDetailController: BBGestureBaseController {

    var urlString: String = ""
//    var titleString: String = ""
//    var shareTitle: String = ""
//    var shareDscription: String = ""
//    var iconurl: String = ""
    
    fileprivate lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: bbNavBarHeight, width: bbScreenWidth, height: 1))
        progressView.trackTintColor = UIColor.white
        progressView.progressTintColor = BBColor(rgbValue: 0x115ACE)
        return progressView
    }()
    
    fileprivate lazy var wkWebView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: bbNavBarHeight, width: bbScreenWidth, height: bbScreenHeight - bbNavBarHeight), configuration: webConfiguration)
        wkWebView.navigationDelegate = self
        
        wkWebView.load(URLRequest(url: URL(string: urlString)!))
        return wkWebView
        
    }()
    
//    private lazy var navitionTitleLabel: UILabel = {
//        let navitionTitleLabel = UILabel(frame: CGRect(x: bbScreenWidth / 2 - 100, y: bbNavBarHeight - 44, width: 200, height: 44))
//        navitionTitleLabel.font = UIFont.init(name: "PingFangSC-Medium", size: 18)
//        navitionTitleLabel.textColor = BBColor(rgbValue: 0x333333)
//        navitionTitleLabel.textAlignment = .center
//        navitionTitleLabel.text = "哈哈哈"
//        return navitionTitleLabel
//    }()
    
    private lazy var navitionView : UIView = {
        let navitionView = UIView(frame: CGRect(x: 0, y: 0, width: bbScreenWidth, height: bbNavBarHeight))
        navitionView.backgroundColor = UIColor.white
        
        let leftBtn = UIButton(frame: CGRect(x: 2, y: bbNavBarHeight - 2 - 40, width: 40, height: 40))
        leftBtn.setImage(UIImage(named: "navigation_news_back"), for: .normal)
        leftBtn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        navitionView.addSubview(leftBtn)
        
        let closeBtn = UIButton(frame: CGRect(x: 42, y: bbNavBarHeight - 2 - 40, width: 40, height: 40))
        closeBtn.setTitle("关闭", for: .normal)
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        closeBtn.setTitleColor(BBColor(rgbValue: 0x333333), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        navitionView.addSubview(closeBtn)
        
        let menuBtn = UIButton(frame: CGRect(x: bbScreenWidth - 40 - 5, y: bbNavBarHeight - 2 - 40, width: 40, height: 40))
        menuBtn.setImage(UIImage(named: "navigation_news_menu"), for: .normal)
        menuBtn.addTarget(self, action: #selector(menuClick), for: .touchUpInside)
        navitionView.addSubview(menuBtn)
        
        return navitionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.statusBarStyle = .default
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(false, animated: animated)
        UIApplication.shared.statusBarStyle = .lightContent
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        
        setupWebView()
    }

    private func setupNavigation() {
        view.addSubview(navitionView)
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
// MARK: - Action
extension BBNewsDetailController {
    @objc private func closeClick(){
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func backClick(){
        
        if wkWebView.canGoBack {
            wkWebView.goBack()
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
    @objc private func menuClick() {
        let v = BBShareView.shareView(shareType: .three)
        v.show {(clsName) in
            
            if clsName! == "微信" {
                self.share(type: .typeWechat)
            }
            
            if clsName! == "朋友圈" {
                self.share(type: .subTypeWechatTimeline)
            }
            
            
            if clsName! == "复制链接" {
                self.pasteBoard(str: "self.urlString")
            }
            
            
            
            v.removeFromSuperview()
        }
    }
    
    private func share(type:SSDKPlatformType){
        // 1.创建分享参数
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: "shareDscription",
                                          images : "iconurl",
                                          url : NSURL(string:"urlString") as URL?,
                                          title : "shareTitle",
                                          type : .auto)
        
        //2.进行分享
        ShareSDK.share(type, parameters: shareParames) { (state : SSDKResponseState, nil, entity : SSDKContentEntity?, error :Error?) in
            
            switch state{
                
            case SSDKResponseState.success:  MBProgressHUD.showTitle("分享成功", to: self.view)
            case SSDKResponseState.fail:    MBProgressHUD.showTitle("授权失败,错误描述:\(String(describing: error))",to: self.view)
            case SSDKResponseState.cancel:  MBProgressHUD.showTitle("操作取消",to: self.view)
                
            default:
                break
            }
            
        }
    }
    
    private func pasteBoard(str:String) {
        //就这两句话就实现了
        let paste = UIPasteboard.general
        paste.string = str
        MBProgressHUD.showTitle("链接已复制", to: view)
    }
}


//MARK:--WKNavigationDelegate
extension BBNewsDetailController : WKNavigationDelegate,WKUIDelegate {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.isHidden = wkWebView.estimatedProgress == 1
            progressView.setProgress(Float(wkWebView.estimatedProgress), animated: true)
            print(wkWebView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
        
//        [js appendString:@"var buyNow = document.getElementsByTagName('header');"];
//        [js appendString:@"buyNow.parentNode.removeChild(buyNow);"];
        webView.evaluateJavaScript("document.getElementsByTagName('header')[0].style.display='none';document.getElementsByClassName('bottomCpa')[0].style.display='none';document.getElementsByClassName('place')[0].style.display='none';document.getElementsByClassName('cont')[0].style.display='none';document.getElementsByClassName('list_load')[0].style.display='none';document.getElementsByClassName('block-title')[0].style.display='none';", completionHandler: nil)
        
    }
    
}

