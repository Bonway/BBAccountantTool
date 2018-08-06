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
    @IBOutlet weak var clickLabel: UILabel!
    
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
            if cellModel?.imgList.list.count ?? 0 > 0 {
                titleImgView.kf.setImage(with: URL(string: (cellModel?.imgList.list[0])!), placeholder: UIImage(named: "blank_placeholder"))
//                if cellModel?.imgList.list.count ?? 0 == 0 
            } else {
                titleImgView.image = UIImage(named: "pic_\(arc4random_uniform(10))")
            }
            
            sourceLabel.text = cellModel?.source
            timeLabel.text = cellModel?.senddate
            clickLabel.text = String(cellModel?.click ?? 0) + "浏览"
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {

    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
    
}
