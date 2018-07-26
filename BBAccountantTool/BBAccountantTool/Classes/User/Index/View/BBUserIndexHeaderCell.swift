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
    
    @IBOutlet weak var vipImageView: UIImageView!
    
    var model: BBUserModel?{
        didSet {
           
            if model?.msg == 1 {
                noLoginView.isHidden = true
                loginView.isHidden = false
                vipImageView.isHidden = false
                if model?.data.isvip == 1 {
                    vipImageView.image = #imageLiteral(resourceName: "user_index_vip_no")
                }
                
                if model?.data.isvip == 2 {
                    vipImageView.image = #imageLiteral(resourceName: "user_index_vip_yes")
                }
                
                loginName.text = model?.data.nickname
                loginDesc.text = "个人账号：\(model?.data.phone ?? "")"
                headerImageView.kf.setImage(with: URL(string: (model?.data.head)!), placeholder: UIImage(named: "home_index_head"))
                headerImageView.layer.masksToBounds = true
            }else{
                noLoginView.isHidden = false
                loginView.isHidden = true
                vipImageView.isHidden = true
                headerImageView.image = UIImage(named: "home_index_head")
                
            }
            
        }
    }
    
    
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
