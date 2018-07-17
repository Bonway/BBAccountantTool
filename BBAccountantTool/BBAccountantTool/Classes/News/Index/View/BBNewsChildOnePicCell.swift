//
//  BBNewsChildOnePicCell.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/16.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBNewsChildOnePicCell: UITableViewCell {

    @IBOutlet weak var cellCenterView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImgView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var browseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.shadowColor = BBColor(rgbValue: 0xdddddd).cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 8.0
        contentView.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
    var cellModel: BBNewsChildArcListModel?{
        
        didSet {
            
            let titleString : String = (cellModel?.title)!
            let attributedString = NSMutableAttributedString(string: (cellModel?.title)!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            paragraphStyle.alignment = .justified
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0,titleString.count))

            titleLabel.attributedText = attributedString
            titleImgView.kf.setImage(with: URL(string: (cellModel?.litpic)!), placeholder: UIImage(named: "blank_zwt"))
            sourceLabel.text = cellModel?.source
            timeLabel.text = cellModel?.pubdate
            
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {

    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
    
}
