//
//  BBNewsChildMorePicCell.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/16.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBNewsChildMorePicCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImgView1: UIImageView!
    @IBOutlet weak var titleImgView2: UIImageView!
    @IBOutlet weak var titleImgView3: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var clickLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
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
            
            if cellModel?.imgList.list.count ?? 0 == 2 {
                titleImgView1.kf.setImage(with: URL(string: (cellModel?.imgList.list[0])!), placeholder: UIImage(named: "blank_placeholder"))
                titleImgView2.kf.setImage(with: URL(string: (cellModel?.imgList.list[1])!), placeholder: UIImage(named: "blank_placeholder"))
            }
            
            if cellModel?.imgList.list.count ?? 0 == 3 {
                titleImgView1.kf.setImage(with: URL(string: (cellModel?.imgList.list[0])!), placeholder: UIImage(named: "blank_placeholder"))
                titleImgView2.kf.setImage(with: URL(string: (cellModel?.imgList.list[1])!), placeholder: UIImage(named: "blank_placeholder"))
                titleImgView3.kf.setImage(with: URL(string: (cellModel?.imgList.list[2])!), placeholder: UIImage(named: "blank_placeholder"))
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
