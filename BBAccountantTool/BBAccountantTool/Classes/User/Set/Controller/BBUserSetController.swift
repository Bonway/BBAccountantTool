//
//  BBUserSetController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBUserSetController: UIViewController {

    @IBOutlet weak var versionsLabel: UILabel!
    @IBOutlet weak var swiftchView: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        setupNavigation()
        
        setupSersions()
    }

    private func setupNavigation() {
        navigationItem.title = "设置"
        let backItem = UIBarButtonItem.init(image: UIImage(named: "navigation_back"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(backClick))
        navigationItem.leftBarButtonItem = backItem
    }
    
    private func setupSersions() {
        let infoDictionary = Bundle.main.infoDictionary!
        versionsLabel.text = "当前版本 v\(infoDictionary["CFBundleShortVersionString"] ?? "")"
    }
    
    
    @objc private func backClick() {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
