//
//  BBUserViewController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/6.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit
class BBUserViewController: BBGestureBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 500, height: 100))
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func click(){
        navigationController?.pushViewController(BBNewsDetailController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    

}
