//
//  BBHomeViewController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit
class BBHomeViewController: BBGestureBaseController {

    private var isEdit : Bool = false
    private var isHideEditBtn : Bool = false
//MARK:--懒加载
    fileprivate lazy var navHeaderView : UIView = {
        let navHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: Int(bbScreenWidth), height: bbNavBarHeight))
        
        let navImageView = UIImageView(image: UIImage(named: "navigation_home_index"))
        navImageView.frame = navHeaderView.frame
        navHeaderView.addSubview(navImageView)
        //首先创建一个模糊效果
//        let blurEffect = UIBlurEffect(style: .light)
//        //接着创建一个承载模糊效果的视图
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        //设置模糊视图的大小（全屏）
//        blurView.frame.size = CGSize(width: navHeaderView.frame.width, height: navHeaderView.frame.height)
//        //添加模糊视图到页面view上（模糊视图下方都会有模糊效果）
//        navHeaderView.addSubview(blurView)
        
        return navHeaderView
    }()
    
    fileprivate lazy var titleLable : UILabel = {
        let titleLable = UILabel(frame: CGRect(x: bbScreenWidth/2-80, y: 28, width: 160, height: 32))
        titleLable.text = "会计工具箱"
        titleLable.textColor = UIColor.white
        titleLable.textAlignment = .center
        titleLable.font = UIFont.boldSystemFont(ofSize: 18)
        return titleLable
    }()
    
    fileprivate lazy var titleLeftBtn : UIButton = {
        let titleLeftBtn = UIButton(frame: CGRect(x: 10, y: 28, width: 60, height: 32))
        titleLeftBtn.setTitle("取消", for: .normal)
        titleLeftBtn.titleLabel?.font = UIFont.init(name: "PingFangSC-Medium", size: 18)
        titleLeftBtn.setTitleColor(UIColor.white, for: .normal)
        titleLeftBtn.addTarget(self, action: #selector(titleLeftBtnClick), for: .touchUpInside)
        titleLeftBtn.isHidden = true
        return titleLeftBtn
    }()
    
    fileprivate lazy var titleRightBtn : UIButton = {
        let titleRightBtn = UIButton(frame: CGRect(x: bbScreenWidth - 70, y: 28, width: 60, height: 32))
        titleRightBtn.setTitle("完成", for: .normal)
        titleRightBtn.setImage(UIImage(named: "home_index_done"), for: .normal)
        titleRightBtn.titleLabel?.font = UIFont.init(name: "PingFangSC-Medium", size: 18)
        titleRightBtn.setTitleColor(UIColor.white, for: .normal)
        titleRightBtn.layoutButton(with: .right, imageTitleSpace: 4)
        titleRightBtn.addTarget(self, action: #selector(titleRightBtnClick), for: .touchUpInside)
        titleRightBtn.isHidden = true
        return titleRightBtn
    }()
    
    
    
    fileprivate lazy var imageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: bbScreenWidth, height: 375.0 / bbScreenWidth * 200))
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "home_index_header_backview")
        
        return imageView
    }()
    
    fileprivate lazy var tableView : UITableView = {

        let tableView = UITableView(frame: CGRect(x: 0, y: 20, width: bbScreenWidth, height: bbScreenHeight+20), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BBHomeIndexTableViewCell.classForCoder(), forCellReuseIdentifier: "BBHomeIndexTableViewCell")
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(CGFloat(bbNavBarHeight-20), 0, 0, 0)
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
        view.backgroundColor = BBColor(rgbValue: 0xf6f6f6)
        view.addSubview(imageView)
        view.addSubview(tableView)
        view.addSubview(navHeaderView)
        view.addSubview(titleLable)
        view.addSubview(titleLeftBtn)
        view.addSubview(titleRightBtn)
    }
    
}
//MARK:--UITableViewDataSource
extension BBHomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BBHomeIndexTableViewCell.cellWithTableView(tableView: tableView, indexPath: indexPath)
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.isHideEditBtn = isHideEditBtn
            cell.isAdd = false
            cell.sectionHeaderTitle = "最近使用"
        }else{
            cell.isHideEditBtn = true
            cell.isAdd = true
            cell.sectionHeaderTitle = "企业财务"
        }
        
        cell.isEdit = isEdit
        
        cell.editBtnBlock = {(btn) in
            self.isEdit = btn.isSelected
            self.isHideEditBtn = true
            self.titleLeftBtn.isHidden = !btn.isSelected
            self.titleRightBtn.isHidden = !btn.isSelected
            self.tableView.reloadData()
            
            
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
//        return CGFloat(bbNavBarHeight)
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        if indexPath.section == 1 && indexPath.row == 0 {
//            return 125
//        }
        return 175
    }
}

//MARK:--UIScrollViewDelegate
extension BBHomeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if scrollView.contentOffset.y <= -44 {
            imageView.y = 0
            navHeaderView.alpha = 0
        }else if scrollView.contentOffset.y < 44 {
            imageView.y = -(scrollView.contentOffset.y + 44)
            navHeaderView.alpha = (scrollView.contentOffset.y + 44) / 64
            imageView.alpha = 1 - (scrollView.contentOffset.y + 44) / 64
        }else {
            imageView.y = -imageView.height + 44
            navHeaderView.alpha = 1
        }
        
        if scrollView.contentOffset.y <= -100 {
            imageView.height = 200 - (scrollView.contentOffset.y + 100)
        }
        
    }
}

//MARK:--Action
extension BBHomeViewController {
    @objc private func titleLeftBtnClick() {
        isEdit = false
        titleLeftBtn.isHidden = true
        titleRightBtn.isHidden = true
        isHideEditBtn = false
        tableView.reloadData()
    }
    
    @objc private func titleRightBtnClick() {
        isEdit = false
        titleLeftBtn.isHidden = true
        titleRightBtn.isHidden = true
        isHideEditBtn = false
        tableView.reloadData()
    }
}
