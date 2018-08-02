//
//  BBUserLoginController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/20.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBUserLoginController: BBGestureBaseController {

    @IBOutlet weak var navigationHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var phoneFieldView: UITextField!
    @IBOutlet weak var passwordFieldView: UITextField!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var secondBtn: UIButton!
    
    private var remainingSeconds: Int = 0 {
        willSet {
            secondBtn.setTitle("\(newValue)秒后获取", for: .normal)
            secondBtn.setTitleColor(BBColor(rgbValue: 0x999999), for: .normal)
            if newValue <= 0 {
                secondBtn.setTitle("重新获取", for: .normal)
                secondBtn.setTitleColor(BBColor(rgbValue: 0x4183E7), for: .normal)
                isCounting = false
            }
        }
    }
    private var countdownTimer: Timer?
    private var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                remainingSeconds = 60
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
            }
            
            secondBtn.isEnabled = !newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        navigationHeight.constant = bbNavBarHeight
        navigationViewHeight.constant = bbNavBarHeight
        
        phoneFieldView.addTarget(self, action: #selector(phoneChange(textField:)), for: .allEditingEvents)
        passwordFieldView.addTarget(self, action: #selector(passwordChange(textField:)), for: .allEditingEvents)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

// MARK: - Action
extension BBUserLoginController {
    
    @IBAction func closeClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func loginClick(_ sender: Any) {
        
        phoneFieldView.resignFirstResponder()
        passwordFieldView.resignFirstResponder()
        let hud = MBProgressHUD.showProgress(view)
        BBNetworkTool.loadData(API: UserProviderType.self, target: .checkLogin(tag: "2", phone: phoneFieldView.text ?? "", code: passwordFieldView.text ?? ""), cache: true , success: { (json)in
            hud?.hide(animated: true)
            let decoder = JSONDecoder()
            let model = try? decoder.decode(BBUserLoginModel.self, from: json)
            
            if model?.msg == 1 {
                self.errorView.isHidden = true
                MBProgressHUD.showTitle(model?.info, to: self.view)
                
                let userDefault = UserDefaults.standard
                userDefault.set(true, forKey: IS_LOGIN_STATUS)
                if model?.data.vip == 2 {
                    userDefault.set(true, forKey: IS_VIP_STATUS)
                }else{
                    userDefault.set(false, forKey: IS_VIP_STATUS)
                }
                userDefault.synchronize()
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                    self.navigationController?.dismiss(animated: true, completion: nil)
                }
            }else if model?.msg == -1 {
                self.errorView.isHidden = true
                let setPasswordController = BBUserSetPasswordController()
                setPasswordController.phoneNum = self.phoneFieldView.text!
                self.navigationController?.pushViewController(setPasswordController, animated: true)
            } else {
                self.errorView.isHidden = false
                MBProgressHUD.showTitle(model?.info, to: self.view)
            }

            
        }) { (error_code, message) in
            hud?.hide(animated: true)
            self.addBlankView(blankType: .requestFailed)
        }
    }
    @IBAction func accountClick(_ sender: Any) {
        navigationController?.pushViewController(BBUserAccountLoginController(), animated: true)
    }
    
    @IBAction func secondClick(_ sender: Any) {
        
        let hud = MBProgressHUD.showProgress(view)
        BBNetworkTool.loadData(API: UserProviderType.self, target: .sendCode(phone: phoneFieldView.text ?? ""), cache: true , success: { (json)in
            hud?.hide(animated: true)
            let decoder = JSONDecoder()
            let model = try? decoder.decode(BBUserGeneralModel.self, from: json)
            MBProgressHUD.showTitle(model?.info, to: self.view)
 
        }) { (error_code, message) in
            hud?.hide(animated: true)
            self.addBlankView(blankType: .requestFailed)
        }
        
        
        isCounting = true
    }
    @objc private func updateTime() {
        remainingSeconds -= 1
    }
    
    @IBAction func weChatClick(_ sender: Any) {
        ShareSDK.cancelAuthorize(.typeWechat)
        ShareSDK.getUserInfo(.typeWechat) { (state, user, error) in
            if state == .success {
                let hud = MBProgressHUD.showProgress(self.view)
                BBNetworkTool.loadData(API: UserProviderType.self, target: .thirdLogin(tag: "1", openid: user?.uid ?? ""), cache: true , success: { (json)in
                    hud?.hide(animated: true)
                    let decoder = JSONDecoder()
                    let model = try? decoder.decode(BBUserLoginModel.self, from: json)

                    if model?.msg == 1 {
                        MBProgressHUD.showTitle(model?.info, to: self.view)
                        
                        let userDefault = UserDefaults.standard
                        userDefault.set(true, forKey: IS_LOGIN_STATUS)
                        if model?.data.vip == 2 {
                            userDefault.set(true, forKey: IS_VIP_STATUS)
                        }else{
                            userDefault.set(false, forKey: IS_VIP_STATUS)
                        }
                        userDefault.synchronize()
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                            self.navigationController?.dismiss(animated: true, completion: nil)
                        }
                    }else if model?.msg == -1 {
                        let bindPhoneController = BBUserBindPhoneController()
                        
                        if ((user?.uid) != nil) {
                            bindPhoneController.openid = user?.uid ?? ""
                        }
                        
                        if ((user?.nickname) != nil) {
                            bindPhoneController.nickname = user?.nickname ?? ""
                        }
                        if ((user?.icon) != nil) {
                            bindPhoneController.head = user?.icon ?? ""
                        }
                        
                        if ((user?.rawData["city"]) != nil) {
                            bindPhoneController.city = (user?.rawData["city"] ?? "" ) as! String
                        }
                        
                        if ((user?.rawData["province"]) != nil) {
                            bindPhoneController.province = (user?.rawData["province"] ?? "") as! String
                        }
                        
                        if ((user?.rawData["country"]) != nil) {
                            bindPhoneController.country = (user?.rawData["country"] ?? "") as! String
                        }
                        
                        if user?.rawData["sex"] != nil {
                            
                            let s = user?.rawData["sex"] as! NSNumber
                            let sex = "\(s)"
                            if sex == "0"  {
                                bindPhoneController.sex = "1"
                            }
                            if sex == "1" {
                                bindPhoneController.sex = "2"
                            }
                            if sex == "2" {
                                bindPhoneController.sex = "0"
                            }
                            
                        }else{
                            bindPhoneController.sex = "0"
                        }
                        
                        self.navigationController?.pushViewController(bindPhoneController, animated: true)
                    } else{
                        MBProgressHUD.showTitle(model?.info, to: self.view)
                    }
                }) { (error_code, message) in
                    hud?.hide(animated: true)
                    self.addBlankView(blankType: .requestFailed)
                }
            }else {
                MBProgressHUD.showTitle("授权信息有误", to: self.view)
            }
        }
    }
    
    
    @objc private func phoneChange(textField:UITextField) {
        if let str = textField.text{
            let expression = "^((1[3,5,8][0-9])|(14[5,7])|(17[0,6,7,8])|(19[7]))\\d{8}$"//"|"表示什么就不用说了吧，[5|7]表示满足其中任意一个即匹配，数量唯一，"[0-3]"则表示满足0到之间的数字即匹配，数量唯一，[^14]表示匹配除1和4以外的任意字符，这里包括了字母，所以建议弹出键盘类型为数字键盘
            let regex = try! NSRegularExpression(pattern: expression, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
            let numberOfMatches = regex.numberOfMatches(in: str, options:.reportProgress, range: NSMakeRange(0, (str as NSString).length))//获取匹配的个数
            if numberOfMatches != 0{//如果匹配，则登录按钮生效，否则反之
                secondBtn.isEnabled = true
                secondBtn.setTitleColor(BBColor(rgbValue: 0x4183E7), for: .normal)
            }else{
                secondBtn.isEnabled = false
                secondBtn.setTitleColor(BBColor(rgbValue: 0x999999), for: .normal)
            }
        }
        
        if textField.text?.count == 11 && passwordFieldView.text?.count == 4 {
            loginBtn.isEnabled = true
        }else{
            loginBtn.isEnabled = false
        }
        errorView.isHidden = true
    }
    
    @objc private func passwordChange(textField:UITextField) {
        
        if textField.text?.count == 4 && phoneFieldView.text?.count == 11 {
            loginBtn.isEnabled = true
        }else{
            loginBtn.isEnabled = false
        }
        errorView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneFieldView.resignFirstResponder()
        passwordFieldView.resignFirstResponder()
    }
    
}

// MARK: - UITextFieldDelegate
extension BBUserLoginController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)//获取输入框接收到的文字
        
        if textField == phoneFieldView {
            if str.count > 11  {
                return false
            }
        }
        if textField == passwordFieldView {
            if str.count > 4  {
                return false
            }
        }
        
        let expression = "^\\d*\\.?\\d{0,2}$"//创建表达式,"*"表示重复0次或更多次，"."表示匹配除换行符以外的任意字符，如果我们想直接匹配"."本身，就得在前边加转义符\\，"?"表示重复0或1次，{0,2}表示重复0或2次，"^","$"分别匹配字符串的开始和末尾，所以整个意思就是，匹配可重复出现的数字+一个"."+两个数字
        let regex = try! NSRegularExpression(pattern: expression, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
        let numberOfMatches = regex.numberOfMatches(in: str, options:.reportProgress, range: NSMakeRange(0, (str as NSString).length))//获取匹配的个数
        return numberOfMatches != 0//如果匹配数量为0则表示不符合输入要求
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneFieldView {
            passwordFieldView.becomeFirstResponder()
            return false
        }
        
        if textField == passwordFieldView {
            textField.resignFirstResponder()
            return true
        }
        return true
    }
    
    
}


