//
//  BBNewsChildController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/13.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBNewsChildController: BBGestureBaseController {
    
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
        tableView.mj_header = BBRefreshHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        tableView.mj_footer = BBRefreshFooter(refreshingTarget: self, refreshingAction: #selector(loadNewData))
//        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    var titleModel: BBNewsIndexTitleDataModel?
    var model : BBNewsChildListModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isEnablePanGesture = false
        
        
//        .newsList(typeid: titleModel?.tid, token: titleModel?.tid.tokenString
        setupView()
        loadDatas()
    }

    private func setupView() {
        view.addSubview(tableView)
    }
    
    private func loadDatas() {
        
//        print("tid\(titleModel?.tid) and:\(titleModel?.tid.tokenString)")
        
        BBNetworkTool.loadData(API: NewsIndexType.self, target: .newsList(typeid: titleModel?.tid ?? "", token: titleModel?.tid.tokenString ?? ""), cache: true , success: { (json)in
            let decoder = JSONDecoder()
            
            let model = try? decoder.decode(BBNewsChildListModel.self, from: json)
            self.model = model
            
//            print(model)
            self.tableView.reloadData()

        }) { (error_code, message) in
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
        
    }
}




// MARK: - UITableViewDataSource
extension BBNewsChildController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = model?.arcList.count ?? 0
        return count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if model?.data[indexPath.row].litpic {
//            <#code#>
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellOneID) as! BBNewsChildOnePicCell
        

        cell.cellModel = model?.arcList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
        //return UITableViewAutomaticDimension
    }
}

// MARK: - UITableViewDelegate
extension BBNewsChildController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
