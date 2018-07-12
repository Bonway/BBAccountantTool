//
//  ContentViewController.swift
//  Example
//
//  Created by Daniels on 2018/2/24.
//  Copyright © 2018年 Daniels. All rights reserved.
//

import UIKit
//import DNSPageView

class ContentViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ContentViewController: DNSPageReloadable {
    func titleViewDidSelectedSameTitle() {
        print("重复点击了标题")
    }

    func contentViewDidEndScroll() {
        print("contentView滑动结束")
    }
}
