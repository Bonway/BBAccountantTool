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
    var wkWebView: WKWebView = {
        
        let wkWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: bbScreenWidth, height: bbScreenWidth - bbNavBarHeight))
        wkWebView.backgroundColor = UIColor.yellow
        return wkWebView
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setupWebView()

        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(test), for: .touchUpInside)
        
        view.addSubview(btn)
        view.backgroundColor = UIColor.white
        
    }
    
    @objc func test(){
        self.navigationController?.pushViewController(BBHomeViewController(), animated: true)
    }
    
    private func setupWebView(){
        view.addSubview(wkWebView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
