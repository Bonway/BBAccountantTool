//
//  BBHomeCollectionCell.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBHomeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var titleName : String = "" {
        didSet {
            titleLabel.text = titleName
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

    
    
}
