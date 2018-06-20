//
//  BBHomeViewController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBHomeViewController: BBGestureBaseController {

    
//MARK:--懒加载

    
    fileprivate lazy var tableView : UITableView = {

        let tableView = UITableView(frame: CGRect(x: 0, y: -20, width: bbScreenWidth, height: bbScreenHeight+20), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BBHomeIndexTableViewCell.classForCoder(), forCellReuseIdentifier: "BBHomeIndexTableViewCell")
        tableView.backgroundColor = UIColor.red
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        setupTabBar()
        
        setupTableView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
    }
    
}
//MARK:--UITableViewDataSource
extension BBHomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BBHomeIndexTableViewCell.cellWithTableView(tableView: tableView, indexPath: indexPath)
        if indexPath.section == 1 && indexPath.row == 0 {
            cell.isHideSectionHeader = true
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
}

//MARK:--UITableViewDelegate
extension BBHomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.black
            return headerView
        }
        return nil
    }
    
    //返回分区头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        return CGFloat(bbNavBarHeight)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

        return 175
    }
}
