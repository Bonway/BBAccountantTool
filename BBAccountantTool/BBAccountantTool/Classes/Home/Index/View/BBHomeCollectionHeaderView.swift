//
//  BBHomeCollectionHeaderView.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBHomeCollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var sectionHeaderTitleLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editBtn.layer.borderColor = BBColor(rgbValue: 0xCCCCCC).cgColor
    }
    
//    @IBAction func editBtnClick(_ sender: Any) {
//        
//    }
    
}
