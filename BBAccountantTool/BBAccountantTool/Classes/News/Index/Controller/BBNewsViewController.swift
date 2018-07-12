//
//  BBNewsViewController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/6.
//  Copyright © 2018年 Bonway. All rights reserved.
//


import UIKit
class BBNewsViewController: BBGestureBaseController {

    fileprivate lazy var imageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: bbScreenWidth, height: 375.0 / bbScreenWidth * 200))
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "home_index_header_backview")
        return imageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        automaticallyAdjustsScrollViewInsets = false
        
        let style = DNSPageStyle()
        // 设置标题内容
        let titles = ["热点", "视dasf频", "娱乐", "要", "体adfdsa育" , "科技" , "汽车" , "时尚" , "图片" , "游戏" , "房产"]
        
        // 创建每一页对应的controller
        let childViewControllers: [ContentViewController] = titles.map { _ -> ContentViewController in
            let controller = ContentViewController()
            controller.view.backgroundColor = UIColor.blue
            print("测试")
            return controller
        }
        
        
        let size = UIScreen.main.bounds.size
        // 创建对应的DNSPageView，并设置它的frame
        let pageView = DNSPageView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height), style: style, titles: titles, childViewControllers: childViewControllers)
        view.addSubview(pageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    


}
