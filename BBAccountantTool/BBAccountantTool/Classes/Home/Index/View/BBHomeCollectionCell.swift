//
//  BBHomeCollectionCell.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBHomeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var cornerImageView: UIImageView!
    
    var isEdit : Bool = false {
        didSet {
            cornerImageView.isHidden = !isEdit
        }
    }
    
    var isAdd : Bool = true {
        didSet {
            if isAdd {
                cornerImageView.image = UIImage(named: "home_index_item_add")
            }else {
                cornerImageView.image = UIImage(named: "home_index_item_del")
            }
        }
    }
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var titleName : String = "" {
        didSet {
//            titleLabel.text = titleName
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    

    
    
}
