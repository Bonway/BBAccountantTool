//
//  BBHomeCollectionCell.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit
import Kingfisher

class BBHomeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var cornerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
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
    
    
    var itmeModel: BBHomeIndexDataChildModel?{
        didSet {
            titleLabel.text = itmeModel?.title
            imageView.kf.setImage(with: URL(string: (itmeModel?.iconurl)!), placeholder: UIImage(named: "blank_zwt"))
            if (itmeModel?.h5url.isEmpty)! {
                alpha = 0.3
            }else{
                alpha = 1.0
            }
        }
    }
    


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
