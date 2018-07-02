//
//  BBHomeIndexTableViewCell.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBHomeIndexTableViewCell: UITableViewCell {

    var editBtnBlock:((UIButton) -> ())?
    var itemBlock:((String,String,String,String) -> ())?
    var itemErrorBlock:(() -> ())?
    var isHideEditBtn : Bool = false
    var isAdd : Bool = false
    
    var cellBackView = UIView()
    var cellBackImageView = UIImageView()
    
    var isEdit : Bool = false {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var sectionModel: BBHomeIndexDataModel? {
        didSet{
            
            var cellRow = 0
            if (sectionModel?.child.count ?? 0) % 4 == 0{
                cellRow = (sectionModel?.child.count ?? 0) / 4 - 1
            }else{
                cellRow = (sectionModel?.child.count ?? 0) / 4
            }
            
            collectionView.height = CGFloat(50 + 100 + 78 * cellRow)-5
            cellBackView.height = CGFloat(100 + 78 * cellRow)-5
            cellBackImageView.height = CGFloat(100 + 78 * cellRow)-5
        }
    }
    
    fileprivate lazy var collectionView : UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (bbScreenWidth - 18*2 - 7*3)/4, height: 78)
        layout.minimumInteritemSpacing = 7
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(5, 18, 5, 18)
        
//        let cellRow = (sectionModel?.child.count ?? 0) / 4
        
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: Int(bbScreenWidth), height: 175), collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cellBackView = UIView(frame: CGRect(x: 0, y: 0, width: Int(bbScreenWidth), height: 175))
        cellBackImageView = UIImageView(image: UIImage(named: "home_index_section_cell"))
        cellBackImageView.frame = CGRect(x: 12, y: 50, width: Int(bbScreenWidth - 24), height: 175)
        cellBackView.addSubview(cellBackImageView)
        
        collectionView.backgroundView = cellBackView
        
        collectionView.register(UINib.init(nibName: "BBHomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BBHomeCollectionCell")
        collectionView.register(UINib.init(nibName: "BBHomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "BBHomeCollectionHeaderView")

        collectionView.backgroundColor = UIColor.clear
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
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(collectionView)
        
    }
}


//MARK:--UICollectionViewDataSource
extension BBHomeIndexTableViewCell : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionModel?.child.count ?? 0
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BBHomeCollectionCell", for: indexPath) as! BBHomeCollectionCell
        cell.itmeModel = sectionModel?.child[indexPath.row]
        cell.isEdit = isEdit
        cell.isAdd = isAdd
        
        if isEdit && !isAdd {
            
            let anim = CABasicAnimation(keyPath: "transform.rotation")
            anim.fromValue = (-M_1_PI/4)
            anim.toValue = (M_1_PI/4)
            anim.duration = 0.13
            anim.repeatCount = MAXFLOAT
            anim.autoreverses = true
            cell.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            //            cell.layer.shouldRasterize = true
            cell.layer.add(anim, forKey: "rotation")
            
        }
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview:BBHomeCollectionHeaderView!
        if kind == UICollectionElementKindSectionHeader
        {
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BBHomeCollectionHeaderView", for: indexPath) as! BBHomeCollectionHeaderView
            reusableview.sectionHeaderTitleLabel.text = sectionModel?.typename
//            reusableview.editBtn.isHidden = isHideEditBtn
            reusableview.editBtn.addTarget(self, action: #selector(editBtnClick(btn:)), for: .touchUpInside)
        }
        
        return reusableview
    }
    
}


//MARK:--UICollectionViewDelegate
extension BBHomeIndexTableViewCell : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if (sectionModel?.child[indexPath.row].h5url.isEmpty)! {
//            MBProgressHUD.showTitle("功能暂无开发", to: self)
            itemErrorBlock!()
        }else{
            itemBlock!((sectionModel?.child[indexPath.row].h5url)!,(sectionModel?.child[indexPath.row].title)!,(sectionModel?.child[indexPath.row].sharetitle)!,(sectionModel?.child[indexPath.row].description)!)
        }
    }
    
}
//MARK:--UICollectionViewDelegateFlowLayout
extension BBHomeIndexTableViewCell : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
//        print(section)
//        if isHideSectionHeader {
//            return CGSize(width: bbScreenWidth, height: 0)
//        }
        return CGSize(width: 0, height: 50)
    }

}
//MARK:--Action
extension BBHomeIndexTableViewCell {
    @objc fileprivate func editBtnClick(btn:UIButton){
        btn.isSelected = !btn.isSelected
        editBtnBlock!(btn)
        btn.isSelected = !btn.isSelected
    }
}
