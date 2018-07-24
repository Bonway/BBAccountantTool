//
//  BBUserIndexHeaderCell.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBUserIndexHeaderCell: UITableViewCell {

    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var noLoginView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginName: UILabel!
    @IBOutlet weak var loginDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerImageView.layer.borderColor = UIColor.white.cgColor
        
        headerImageView.layer.shadowColor = UIColor.black.cgColor
        headerImageView.layer.shadowOpacity = 0.1
        headerImageView.layer.shadowRadius = 8.0
        headerImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        headerImageView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
}
