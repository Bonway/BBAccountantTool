//
//  BBHomeViewController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBHomeViewController: UIViewController {

    
//MARK:--懒加载
    fileprivate lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 35)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: bbScreenWidth, height: bbScreenHeight), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "BBHomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BBHomeCollectionCell")
        // 注册一个headView
//        collectionView.registerClass(CollectionReusableViewHeader.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        // 注册一个footView
//        collectionView.registerClass(CollectionReusableViewFooter.self, forSupplementaryViewOfKind:UICollectionElementKindSectionFooter, withReuseIdentifier: footerIdentifier)
        
        collectionView.backgroundColor = UIColor.red
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    private func setupTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
    }
    
}

//MARK:--代理
extension BBHomeViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 4
        }else {
            return 10
        }
        
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BBHomeCollectionCell", for: indexPath)
        cell.backgroundColor = UIColor.yellow
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
