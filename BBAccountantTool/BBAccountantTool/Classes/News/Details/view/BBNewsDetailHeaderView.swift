//
//  BBNewsDetailHeaderView.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/17.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit
import WebKit

@objc protocol BBNewsDetailHeaderViewDelegate {

    @objc func headerHeight(height:CGFloat)
}

class BBNewsDetailHeaderView: UIView {

    var delegate : BBNewsDetailHeaderViewDelegate?
    
    var headerHeight = CGFloat()
    var model: BBNewsDetailModel?{
        didSet {
            webView.loadHTMLString((model?.body)!, baseURL: URL(string: "https://m.gaodun.com"))
        }
    }
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: bbScreenWidth, height: bbScreenHeight))
        webView.navigationDelegate = self;
        webView.scrollView.isScrollEnabled = false
        return webView
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupSubViews() {
        self.addSubview(webView)
        
    }
        
}

// MARK: - SGPageTitleViewDelegate
extension BBNewsDetailHeaderView: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        webView.evaluateJavaScript("document.body.scrollHeight;") { (result, error) in
            webView.sizeToFit()
            print(webView.scrollView.contentSize.height)
            webView.height = webView.scrollView.contentSize.height
            self.delegate?.headerHeight(height: webView.scrollView.contentSize.height)
        }
    }
}

