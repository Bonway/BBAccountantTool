//
//  BBUserPersonController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/20.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBUserPersonController: UIViewController {

    
    
    
    //header
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var vipImageBgView: UIImageView!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var vipTitleLabel: UILabel!
    @IBOutlet weak var vipTimeLabel: UILabel!
    @IBOutlet weak var vipBtn: UIButton!
    
    //center
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var nickNameView: UIView!
    @IBOutlet weak var sexView: UIView!
    @IBOutlet weak var birthdayView: UIView!
    
    @IBOutlet weak var heaerImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    //bottom
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var updatePasswordView: UIView!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var updatePasswordLabel: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func setupAction() {
        let nickNameGesture = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
        nickNameView.addGestureRecognizer(nickNameGesture)
        
        let phoneViewGesture = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
        phoneView.addGestureRecognizer(phoneViewGesture)
        
        let updatePasswordGesture = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
        updatePasswordView.addGestureRecognizer(updatePasswordGesture)
    }

}
/// MARK ACTION
extension BBUserPersonController {
    
    @IBAction func backClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func vipBtnClick(_ sender: Any) {
        navigationController?.pushViewController(BBUserVipController(), animated: true)
    }
    
    @objc private func tapClick(tap:UITapGestureRecognizer) {
        let tapView = tap.view
        if tapView == nickNameView {
            navigationController?.pushViewController(BBUserNickNameController(), animated: true)
        }
        
        if tapView == phoneView {
            navigationController?.pushViewController(BBUserUpdatePhoneNumController(), animated: true)
        }
        
        if tapView == updatePasswordView {
            navigationController?.pushViewController(BBUserUpdatePasswordNumController(), animated: true)
        }
        
    }
}


