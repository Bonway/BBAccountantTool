//
//  BBHomeIndexTableViewCell.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBHomeIndexTableViewCell: UITableViewCell {

    
    var isHideSectionHeader : Bool = false {
        didSet {
            
        }
    }
    
    fileprivate lazy var collectionView : UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (bbScreenWidth - 15 * 5)/4, height: (375.0 - 15 * 5)/4)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15)
        
//        if isHideSectionHeader {
//            layout.headerReferenceSize = CGSize(width: bbScreenWidth, height: 0) // 页眉宽高
//        }else {
//            layout.headerReferenceSize = CGSize(width: bbScreenWidth, height: 0) // 页眉宽高
//        }
        
        
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: bbScreenWidth, height: bbScreenWidth / 5 + 100), collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "BBHomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BBHomeCollectionCell")
        collectionView.register(UINib.init(nibName: "BBHomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "BBHomeCollectionHeaderView")

        collectionView.backgroundColor = UIColor.red
        return collectionView
    }()
    
    
    class func cellWithTableView(tableView: UITableView , indexPath: IndexPath) -> BBHomeIndexTableViewCell {
        let cellId = "BBHomeIndexTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell as! BBHomeIndexTableViewCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(collectionView)
    }
}


//MARK:--UICollectionViewDataSource
extension BBHomeIndexTableViewCell : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BBHomeCollectionCell", for: indexPath) as! BBHomeCollectionCell
        cell.titleName = "哈哈"
        cell.backgroundColor = UIColor.yellow
        return cell

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        
        var reusableview:BBHomeCollectionHeaderView!
        
        if kind == UICollectionElementKindSectionHeader
        {
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BBHomeCollectionHeaderView", for: indexPath) as! BBHomeCollectionHeaderView
            reusableview.backgroundColor = UIColor.green
            reusableview.sectionHeaderTitleLabel.text = "最近常用"
        }
        else if kind == UICollectionElementKindSectionFooter
        {
            
        }
        
        return reusableview
    }
    
}


//MARK:--UICollectionViewDelegate
extension BBHomeIndexTableViewCell : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
//MARK:--UICollectionViewDelegateFlowLayout
extension BBHomeIndexTableViewCell : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        print(section)
        if isHideSectionHeader {
            return CGSize(width: bbScreenWidth, height: 0)
        }
        return CGSize(width: 0, height: 50)
    }

}

