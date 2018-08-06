//
//  BBNewsChildController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/13.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit
import AudioToolbox

class BBNewsChildController: BBGestureBaseController {
    
//    var isWillDisappear = true
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
//        isWillDisappear = true
    }
//    override func viewWillDisappear(_ animated: Bool) {
////        if isWillDisappear {
//            navigationController?.setNavigationBarHidden(false, animated: animated)
////        }
//        super.viewWillDisappear(animated)
//    }
    
    private lazy var refreshLabel: UILabel = {
        let refreshLabel = UILabel(frame: CGRect(x: bbScreenWidth / 2 - 75, y: 14, width: 150, height: 36))
        refreshLabel.backgroundColor = BBColor(rgbValue: 0x000000, alpha: 0.8)
        refreshLabel.font = UIFont.init(name: "PingFangSC-Medium", size: 14)
        refreshLabel.textColor = UIColor.white
        refreshLabel.textAlignment = .center
        refreshLabel.layer.masksToBounds = true
        refreshLabel.layer.cornerRadius = 18
        return refreshLabel
    }()
    
    private lazy var refreshTopView: UIView = {
       let refreshTopView = UIView(frame: CGRect(x: 0, y: -100, width: bbScreenWidth, height: 50))
        refreshTopView.addSubview(refreshLabel)
        return refreshTopView
    }()
    
    let cellOneID = "newsChildOnePicCell"
    let cellMoreID = "newsChildMorePicCell"
    private lazy var tableView : UITableView = {
       let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: bbScreenWidth, height: bbScreenHeight - bbNavBarHeight))
        tableView.register(UINib.init(nibName: "BBNewsChildOnePicCell", bundle: nil), forCellReuseIdentifier: cellOneID)
        tableView.register(UINib.init(nibName: "BBNewsChildMorePicCell", bundle: nil), forCellReuseIdentifier: cellMoreID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = BBColor(rgbValue: 0xF6F6F6)
        tableView.estimatedRowHeight = 140
//        tableView.mj_header = RefreshHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        let header = RefreshGifHeader { [weak self] in
            
            self?.loadNewData()
            // 获取视频的新闻列表数据
//            NetworkTool.loadApiNewsFeeds(category: category, ttFrom: .pull, {
            
//                self!.player.removeFromSuperview()
//                self!.maxBehotTime = $0
//                self!.news = $1
//                self!.tableView.reloadData()
//            })
        }
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
        
        
        let footer = RefreshAutoGifFooter { [weak self] in
            
            self?.loadMoreData()
            
        }
        footer?.stateLabel.isHidden = true
        tableView.mj_footer = footer
//        tableView.mj_footer = BBRefreshFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
        
        
        
        tableView.mj_footer.isHidden = true
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    var titleModel: BBNewsIndexTitleDataModel?
    var model : BBNewsChildListModel?
    var page : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isEnablePanGesture = false
        setupView()
        loadDatas()
        
    }

    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(refreshTopView)
    }
    
    private func loadDatas() {
        let hud = MBProgressHUD.showProgress(view)
        BBNetworkTool.loadData(API: NewsIndexType.self, target: .newsList(typeid: titleModel?.tid ?? "", token: titleModel?.tid.tokenString ?? "",page: String(self.page)), cache: true , success: { (json)in
            hud?.hide(animated: true)
            let decoder = JSONDecoder()
            let model = try? decoder.decode(BBNewsChildListModel.self, from: json)
            self.model = model
            self.page = 2
            self.tableView.reloadData()
            self.tableView.mj_footer.isHidden = false
        }) { (error_code, message) in
            hud?.hide(animated: true)
            self.addBlankView(blankType: .requestFailed)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

// MARK: - #ACTION
extension BBNewsChildController{
    @objc private func loadNewData() {
        
        
        BBNetworkTool.loadData(API: NewsIndexType.self, target: .newsNewList(typeid: titleModel?.tid ?? "", token: titleModel?.tid.tokenString ?? "", pagesize: "6", since_id: model?.arcList![0].id ?? ""), cache: true , success: { (json)in
            
            let decoder = JSONDecoder()
            let model = try? decoder.decode(BBNewsChildListModel.self, from: json)
            if model?.msg == 3 {
                self.tableView.reloadData()
            }else{
                let array = (model?.arcList)! + (self.model?.arcList)!
                self.model?.arcList = array
                self.tableView.reloadData()
            }
            
            self.refreshLabel.text = model?.info
            
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.refreshTopView.y = 0
            }, completion: { (true) in
                UIView.animate(withDuration: 0.25, delay: 1, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.refreshTopView.y = -100
                }, completion: { (true) in

                })
            })
            
            self.tableView.mj_header.endRefreshing()
//            if self!.tableView.mj_header.isRefreshing { self!.tableView.mj_header.endRefreshing() }
        }) { (error_code, message) in
            self.tableView.mj_header.endRefreshing()
            self.addBlankView(blankType: .requestFailed)
        }
    }
    @objc private func loadMoreData() {
        
        BBNetworkTool.loadData(API: NewsIndexType.self, target: .newsList(typeid: titleModel?.tid ?? "", token: titleModel?.tid.tokenString ?? "",page: String(self.page)), cache: true , success: { (json)in
            
            let decoder = JSONDecoder()
            self.page += 1
            let model = try? decoder.decode(BBNewsChildListModel.self, from: json)
            let array = (self.model?.arcList)! + (model?.arcList)!
            self.model?.arcList = array
            
            self.tableView.reloadData()
            self.tableView.mj_footer.endRefreshing()
            
            
            
        }) { (error_code, message) in
            self.tableView.mj_footer.endRefreshing()
            self.addBlankView(blankType: .requestFailed)
        }
        
    }
}




// MARK: - UITableViewDataSource
extension BBNewsChildController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = model?.arcList?.count ?? 0
        return count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let count = model?.arcList![indexPath.row].imgList.list.count ?? 0
        if count > 1 {
            let moreCell = tableView.dequeueReusableCell(withIdentifier: cellMoreID) as! BBNewsChildMorePicCell
            moreCell.cellModel = model?.arcList![indexPath.row]
            return moreCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellOneID) as! BBNewsChildOnePicCell
        cell.cellModel = model?.arcList![indexPath.row]
        return cell
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = model?.arcList![indexPath.row].imgList.list.count ?? 0
        if count > 1 {
            return UITableViewAutomaticDimension
        }
        return 140
    }
}

// MARK: - UITableViewDelegate
extension BBNewsChildController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
//        isWillDisappear = false
        let newsDetailController = BBNewsDetailController()
        newsDetailController.urlString = "https://m.gaodun.com\(model?.arcList![indexPath.row].arcurl ?? "")"
        newsDetailController.shareTitle = model?.arcList![indexPath.row].title ?? ""
        newsDetailController.shareDscription = model?.arcList![indexPath.row].description ?? ""
        newsDetailController.iconurl = model?.arcList![indexPath.row].litpic ?? ""
        navigationController?.pushViewController(newsDetailController, animated: true)
    }
}
