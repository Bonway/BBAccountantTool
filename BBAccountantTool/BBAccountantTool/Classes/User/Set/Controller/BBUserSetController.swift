//
//  BBUserSetController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/19.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBUserSetController: BBGestureBaseController {

    @IBOutlet weak var versionsLabel: UILabel!
    @IBOutlet weak var swiftchView: UISwitch!
    @IBOutlet weak var versionView: UIView!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    var msg: Int = 0
    
    
    var mainView = UIView()
    
    var updateVersionView = BBUserSetVersionView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        setupNavigation()
        
        setupSersions()
    }

    private func setupNavigation() {
        view.backgroundColor = BBColor(rgbValue: 0xf6f6f6)
        navigationItem.title = "设置"
        let backItem = UIBarButtonItem.init(image: UIImage(named: "navigation_back"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(backClick))
        navigationItem.leftBarButtonItem = backItem
    }
    
    private func setupSersions() {
        let infoDictionary = Bundle.main.infoDictionary!
        versionsLabel.text = "当前版本 v\(infoDictionary["CFBundleShortVersionString"] ?? "")"
        
        
        let versionViewGesture = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
        versionView.addGestureRecognizer(versionViewGesture)
        
        if msg == 1 {
            logoutBtn.isHidden = false
        }else{
            logoutBtn.isHidden = true
        }
    }
    
    
    @objc private func backClick() {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}




extension BBUserSetController {
    
    
    @objc private func mainViewClick() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.updateVersionView.y = bbScreenHeight
            self.mainView.alpha = 0
        }) { (true) in
            self.mainView.removeFromSuperview()
        }
    }
    
    
    @IBAction func sigoutClick(_ sender: Any) {
        
        let hud = MBProgressHUD.showProgress(view)
        BBNetworkTool.loadData(API: UserProviderType.self, target: .loginout, cache: true , success: { (json)in
            hud?.hide(animated: true)
            let decoder = JSONDecoder()
            let model = try? decoder.decode(BBUserGeneralModel.self, from: json)
            
            MBProgressHUD.showTitle(model?.info, to: self.view)
            if model?.msg == 1 {
                
                let userDefault = UserDefaults.standard
                userDefault.set(false, forKey: IS_LOGIN_STATUS)
                userDefault.set(false, forKey: IS_VIP_STATUS)
                userDefault.synchronize()
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }) { (error_code, message) in
            hud?.hide(animated: true)
            self.addBlankView(blankType: .requestFailed)
        }
        
    }
    
    
    @objc private func tapClick(tap:UITapGestureRecognizer) {
        let tapView = tap.view
        
        if tapView == versionView {
            
            let hud = MBProgressHUD.showProgress(view)
            BBNetworkTool.loadData(API: UserProviderType.self, target: .versionIOS , cache: true , success: {(json)in
                hud?.hide(animated: true)
                let decoder = JSONDecoder()
                let model = try? decoder.decode(BBUserSetVersionModel.self, from: json)
                
                
                if model?.msg == 1 {
                    self.mainView = UIView(frame: (self.tabBarController?.view.bounds)!)
                    self.mainView.backgroundColor = BBColor(rgbValue: 0x000000, alpha: 0.4)
                    let mainViewGesture = UITapGestureRecognizer(target: self, action: #selector(self.mainViewClick))
                    self.mainView.addGestureRecognizer(mainViewGesture)
                    self.mainView.alpha = 0
                    self.tabBarController?.view.addSubview(self.mainView)
                    self.updateVersionView = BBUserSetVersionView(frame: CGRect(x: 0, y: bbScreenHeight, width: 270, height: 418))
                    self.updateVersionView.centerX = bbScreenWidth / 2
                    self.updateVersionView.versionLabel.text = model?.data.code
                    self.updateVersionView.messageLabel.text = model?.data.message
                    
                    self.updateVersionView.canleBtnBlock = {[weak self] in
                        self?.mainViewClick()
                    }
                    self.updateVersionView.sureBtnBlock = {[weak self] in
                        self?.mainViewClick()
                        
                        let urlString = "itms-apps://itunes.apple.com/app/id1407125955"
                        let url = NSURL(string: urlString)
                        UIApplication.shared.openURL(url! as URL)
                        
                    }
                    
                    self.mainView.addSubview(self.updateVersionView)
                    
                    UIView.animate(withDuration: 0.5) {
                        self.mainView.alpha = 1
                        self.updateVersionView.centerY = bbScreenHeight/2  - 50
                    }
                    
                }else {
                    MBProgressHUD.showTitle(model?.info, to: self.view)
                }
            }) { (error_code, message) in
                hud?.hide(animated: true)
                self.addBlankView(blankType: .requestFailed)
            }
            
            
        }
    }
}

