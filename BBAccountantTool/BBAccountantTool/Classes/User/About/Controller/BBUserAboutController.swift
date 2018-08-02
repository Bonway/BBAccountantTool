//
//  BBUserAboutController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBUserAboutController: UIViewController {

    
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var weChatView: UIView!
    @IBOutlet weak var versionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        let infoDictionary = Bundle.main.infoDictionary!
        versionsLabel.text = "当前版本 v\(infoDictionary["CFBundleShortVersionString"] ?? "")"
        
        
        let aboutViewGesture = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
        aboutView.addGestureRecognizer(aboutViewGesture)
        
        let weChatViewGesture = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
        weChatView.addGestureRecognizer(weChatViewGesture)
    }

    private func setupView() {
        view.backgroundColor = BBColor(rgbValue: 0xf6f6f6)
        navigationItem.title = "关于会计工具箱"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navigation_back"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(backClick))
    }
    @objc private func backClick() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tapClick(tap:UITapGestureRecognizer) {

        let tapView = tap.view
        
        if tapView == aboutView {
            let webController = BBHomeWebController()
            webController.iconurl = "iconurl"
            webController.titleString = "关于我们"
            webController.urlString = "https://fagui.gaodun.com/index/toolsabout"
            webController.shareTitle = "关于我们"
            webController.shareDscription = "关于我们"
            navigationController?.pushViewController(webController, animated: true)
        }
        
        if tapView == weChatView {
            let webController = BBHomeWebController()
            webController.iconurl = "iconurl"
            webController.titleString = "微信公众号"
            webController.urlString = "https://fagui.gaodun.com/index/toolswx"
            webController.shareTitle = "微信公众号"
            webController.shareDscription = "微信公众号"
            navigationController?.pushViewController(webController, animated: true)
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
