//
//  BBUserViewController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBUserViewController: BBGestureBaseController {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let cellID = "userCell"
    let cellTopID = "userTopCell"
    let cellBottomID = "userBottomCell"
    let cellHeaderID = "userHeaderCell"
    
    private let cellInfo = [["imageName": "user_index_collect", "title": "我的收藏"],
                                   ["imageName": "user_index_opinion", "title": "吐个槽"],
                                   ["imageName": "user_index_aboutus", "title": "关于会计工具箱"],
                                   ["imageName": "user_index_grade", "title": "给我打分"]]
    
    fileprivate lazy var navHeaderView : UIView = {
        
        let setBtn = UIButton(frame: CGRect(x: bbScreenWidth - 40 - 5, y: bbNavBarHeight - 2 - 40 - bbStatusHeight, width: 40, height: 40))
        setBtn.setImage(UIImage(named: "navigation_user_set"), for: .normal)
        setBtn.addTarget(self, action: #selector(titleRightBtnClick), for: .touchUpInside)
        
        let navHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: Int(bbScreenWidth), height: Int(bbNavBarHeight - bbStatusHeight)))
        navHeaderView.backgroundColor = UIColor.clear
        navHeaderView.addSubview(titleLable)
        navHeaderView.addSubview(setBtn)
        return navHeaderView
    }()
    
    fileprivate lazy var titleLable : UILabel = {
        let titleLable = UILabel(frame: CGRect(x: bbScreenWidth/2-80, y: 5, width: 160, height: 32))
        titleLable.text = "我的"
        titleLable.textColor = UIColor.white
        titleLable.textAlignment = .center
        titleLable.font = UIFont.boldSystemFont(ofSize: 18)
        return titleLable
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//        super.viewWillDisappear(animated)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        
    }

    private func setupTableView() {
        tableView.tableHeaderView = navHeaderView
        view.backgroundColor = BBColor(rgbValue: 0xf6f6f6)
        tableView.register(UINib.init(nibName: "BBUserIndexCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.register(UINib.init(nibName: "BBUserIndexTopCell", bundle: nil), forCellReuseIdentifier: cellTopID)
        tableView.register(UINib.init(nibName: "BBUserIndexBottomCell", bundle: nil), forCellReuseIdentifier: cellBottomID)
        
        tableView.register(UINib.init(nibName: "BBUserIndexHeaderCell", bundle: nil), forCellReuseIdentifier: cellHeaderID)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
}

//MARK:--Action
extension BBUserViewController {
    @objc private func titleLeftBtnClick() {
    
    }
    
    @objc private func titleRightBtnClick() {
        navigationController?.pushViewController(BBUserSetController(), animated: true)
    }
}

//MARK:--UITableViewDataSource
extension BBUserViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellHeaderID) as! BBUserIndexHeaderCell
            return cell
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellTopID) as! BBUserIndexTopCell
                let dict = cellInfo[indexPath.row]
                let imageName = dict["imageName"]
                let title = dict["title"]
                cell.cellImageView.image = UIImage(named: imageName!)
                cell.cellTitleLabel.text = title
                return cell
            }
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellBottomID) as! BBUserIndexBottomCell
                let dict = cellInfo[indexPath.row]
                let imageName = dict["imageName"]
                let title = dict["title"]
                cell.cellImageView.image = UIImage(named: imageName!)
                cell.cellTitleLabel.text = title
                return cell
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! BBUserIndexCell
        let dict = cellInfo[indexPath.row]
        let imageName = dict["imageName"]
        let title = dict["title"]
        cell.cellImageView.image = UIImage(named: imageName!)
        cell.cellTitleLabel.text = title
        return cell
    }
    
}

extension BBUserViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 156
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 || indexPath.row == 3 {
                return 52+12
            }
        }
        return 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let loginViewController = BBNavigationController(rootViewController: BBUserLoginController())
            loginViewController.modalTransitionStyle = .flipHorizontal
            navigationController?.present(loginViewController, animated: true, completion: nil)
        }
        
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                navigationController?.pushViewController(BBUserPersonController(), animated: true)
            }
            if indexPath.row == 2 {
                navigationController?.pushViewController(BBUserAboutController(), animated: true)
            }
        }
    }
    

}
//MARK:--UIScrollViewDelegate
extension BBUserViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 140 {
            imgView.y = 0
        }else if scrollView.contentOffset.y < imgView.height + 140 {
            imgView.y = -(scrollView.contentOffset.y - 140)
        }else {
            imgView.y = -imgView.height
        }
        if scrollView.contentOffset.y <= 0{
            imgView.height = 375.0 / bbScreenWidth * 200 - scrollView.contentOffset.y
        }
    }
}
