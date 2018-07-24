//
//  BBNewsViewController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/6.
//  Copyright © 2018年 Bonway. All rights reserved.
//


import UIKit
//import SGPagingView

class BBNewsViewController: BBGestureBaseController {

    var model: BBNewsIndexTitleModel?
    
    /// 标题和内容
    
    
    private var pageTitleView: SGPageTitleView?
    private var pageContentView: SGPageContentCollectionView?

    /// 添加频道按钮
//    private lazy var addChannelButton: UIButton = {
//        let addChannelButton = UIButton(frame: CGRect(x: bbScreenWidth - 300, y: 0, width: 40, height: 40))
//        addChannelButton.theme_setImage("images.add_channel_titlbar_thin_new_16x16_", forState: .normal)
//        let separatorView = UIView(frame: CGRect(x: 0, y: newsTitleHeight - 1, width: newsTitleHeight, height: 1))
//        separatorView.theme_backgroundColor = "colors.separatorViewColor"
//        addChannelButton.addSubview(separatorView)
//        return addChannelButton
//    }()
    
    
    fileprivate lazy var imageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: bbScreenWidth, height: bbNavBarHeight))
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "navigation_home_index")
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
        loadDatas()
    }

    private func loadDatas() {
        
        BBNetworkTool.loadData(API: NewsIndexType.self, target: .title, cache: true , success: { (json)in
            let decoder = JSONDecoder()
            let model = try? decoder.decode(BBNewsIndexTitleModel.self, from: json)
            self.model = model
            self.setupView()
        }) { (error_code, message) in
            self.addBlankView(blankType: .requestFailed)
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
}

extension BBNewsViewController {
    private func setupView() {
        view.addSubview(imageView)
        
        var nameArray : [String] = []
        var childArray : [BBNewsChildController] = []
        let count = model?.data.count ?? 0
        for i in 0..<count {
            nameArray.append((model?.data[i].name)!)
            let childController = BBNewsChildController()
            childController.titleModel = model?.data[i]
            childArray.append(childController)
        }
        
        //配置信息
        let configuration = SGPageTitleViewConfigure()
        configuration.titleColor = BBColor(rgbValue: 0xffffff, alpha: 0.5)
        configuration.titleSelectedColor = .white
        configuration.titleFont = UIFont.init(name: "PingFangSC-Medium", size: 16)
        configuration.indicatorStyle = SGIndicatorStyleDefault
        configuration.indicatorColor = BBColor(rgbValue: 0xffffff, alpha: 0.2)
        configuration.indicatorToBottomDistance = 16;
        configuration.indicatorCornerRadius = 3;
        configuration.indicatorHeight = 6;
        
        // 标题名称的数组
        self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: bbStatusHeight+3, width: bbScreenWidth, height: (bbNavBarHeight - bbStatusHeight-3)), delegate: self, titleNames: nameArray, configure: configuration)
        self.pageTitleView!.backgroundColor = .clear
        self.view.addSubview(self.pageTitleView!)

        
        // 内容视图
        self.pageContentView = SGPageContentCollectionView(frame: CGRect(x: 0, y: bbNavBarHeight, width: bbScreenWidth, height: bbScreenHeight - bbNavBarHeight), parentVC: self, childVCs: childArray)
        self.pageContentView!.delegatePageContentCollectionView = self
        self.view.addSubview(self.pageContentView!)
    }
}

// MARK: - SGPageTitleViewDelegate
extension BBNewsViewController: SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate {
    /// 联动 pageContent 的方法
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentView!.setPageContentCollectionViewCurrentIndex(selectedIndex)
    }
    
    /// 联动 SGPageTitleView 的方法
    func pageContentCollectionView(_ pageContentView: SGPageContentCollectionView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView!.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
    
    
}
