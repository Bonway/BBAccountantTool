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
    var iconurl: String = ""
    
//    fileprivate lazy var headerView: UIImageView = {
//        let headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: bbScreenWidth, height: 0))
////        headerView.backgroundColor = UIColor.red
//        headerView.image = UIImage(named: "home_index_header_backview")
//        return headerView
//    }()
    
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
//        wkWebView.scrollView.delegate = self
//        wkWebView.scrollView.mj_header = MJRefreshHeader.init(refreshingBlock: {
//
//        })
//            [MJRefreshHeader headerWithRefreshingBlock:^{
            //刷新请求
//            }];
//        wkWebView.scrollView.hea
        
        wkWebView.load(URLRequest(url: URL(string: urlString)!))
        return wkWebView
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        
        setupWebView()
        
    }
    
    private func setupNavigation(){
        navigationItem.title = titleString
        
        let backItem = UIBarButtonItem.init(image: UIImage(named: "navigation_back"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(backClick))
        
        let closeBtn = UIButton(type: .custom)
        closeBtn.setTitle("关闭", for: .normal)
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        closeBtn.setTitleColor(UIColor.white, for: .normal)
        closeBtn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        
        let closeItem = UIBarButtonItem.init(customView: closeBtn)
        
        self.navigationItem.leftBarButtonItems = [backItem,closeItem]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navigation_menu"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(menuClick))
        
    }
    
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
    
    @objc private func menuClick(){
        // 1> 实例化视图
        let v = BBShareView.shareView()
        v.show {(clsName) in
            
            if clsName! == "微信" {
                self.share(type: .typeWechat)
            }
            
            if clsName! == "朋友圈" {
                self.share(type: .subTypeWechatTimeline)
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
//        view.addSubview(headerView)       
        view.addSubview(progressView)
        wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

    deinit {
        wkWebView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    
    
    private func share(type:SSDKPlatformType){
        // 1.创建分享参数
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: shareDscription,
                                          images : iconurl,
                                          url : NSURL(string:urlString) as URL?,
                                          title : shareTitle,
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
//            print(wkWebView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
    
}

//extension BBHomeWebController : UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        var diff =  -wkWebView.scrollView.contentOffset.y;
//        print(wkWebView.scrollView.contentOffset.y)
//        if (wkWebView.scrollView.contentOffset.y < 0) {
//            headerView.height = -wkWebView.scrollView.contentOffset.y
//        }
////            CGFloat oldH = self.headerDefaultSize.height;
////            CGFloat oldW = self.headerDefaultSize.width;
////
////            CGFloat newH = oldH + diff;
////            CGFloat newW = oldW *newH/oldH;
////
////            self.headerView.frame  = CGRectMake(0, 0, newW, newH);
////            self.headerView.center = CGPointMake(oldW/2.0f, (oldH-diff)/2.0f);
////
////
//    }
//}

