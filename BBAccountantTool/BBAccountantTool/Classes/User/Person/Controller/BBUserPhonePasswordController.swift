//
//  BBUserPhonePasswordController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/26.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBUserPhonePasswordController: BBGestureBaseController {

    
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var twoView: UIView!
    @IBOutlet weak var threeView: UIView!
    @IBOutlet weak var fourView: UIView!
    
    @IBOutlet weak var oneField: BBTextField!
    @IBOutlet weak var twoField: BBTextField!
    @IBOutlet weak var threeField: BBTextField!
    @IBOutlet weak var fourField: BBTextField!
    
    @IBOutlet weak var secondBtn: UIButton!
    
    
    
    private var remainingSeconds: Int = 0 {
        willSet {
            secondBtn.setTitle("\(newValue)s后重新获取", for: .disabled)
            if newValue <= 0 {
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
    
    
    @objc private func updateTime() {
        remainingSeconds -= 1
    }
    
    @IBAction func sendClick(_ sender: Any) {
        
        let hud = MBProgressHUD.showProgress(self.view)
        BBNetworkTool.loadData(API: UserProviderType.self, target: .retrievePhone , cache: true , success: { (json)in
            hud?.hide(animated: true)
            let decoder = JSONDecoder()
            let model = try? decoder.decode(BBUserGeneralModel.self, from: json)
            MBProgressHUD.showTitle(model?.info, to: self.view)
            
        }) { (error_code, message) in
            hud?.hide(animated: true)
//            self.addBlankView(blankType: .requestFailed)
            self.addBlankView(BBBlankTypeRequestFailed)
        }
        
        isCounting = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        sendClick(secondBtn)
        
    }
    
    
    private func setupView() {
        
        view.backgroundColor = BBColor(rgbValue: 0xf6f6f6)
        
        oneView.layer.borderColor = BBColor(rgbValue: 0x397DE9).cgColor
        twoView.layer.borderColor = BBColor(rgbValue: 0x397DE9).cgColor
        threeView.layer.borderColor = BBColor(rgbValue: 0x397DE9).cgColor
        fourView.layer.borderColor = BBColor(rgbValue: 0x397DE9).cgColor
        
        oneField.addTarget(self, action: #selector(passwordChange(textField:)), for: .allEditingEvents)
        twoField.addTarget(self, action: #selector(passwordChange(textField:)), for: .allEditingEvents)
        threeField.addTarget(self, action: #selector(passwordChange(textField:)), for: .allEditingEvents)
        fourField.addTarget(self, action: #selector(passwordChange(textField:)), for: .allEditingEvents)

        fourField.addTarget(self, action: #selector(passwordDid(textField:)), for: .editingDidEnd)
        
        
        
        oneField.bbDelegate = self
        twoField.bbDelegate = self
        threeField.bbDelegate = self
        fourField.bbDelegate = self
        
        navigationItem.title = "填写验证码"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navigation_back"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(backClick))
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}



extension BBUserPhonePasswordController {
    
    @objc private func backClick() {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        oneField.resignFirstResponder()
        twoField.resignFirstResponder()
        threeField.resignFirstResponder()
        fourField.resignFirstResponder()
    }
    
    @objc private func passwordChange(textField:UITextField) {
        
        if textField == oneField && textField.text?.count == 1 {
            twoField.becomeFirstResponder()
        }
        
        if textField == twoField && textField.text?.count == 1 {
            threeField.becomeFirstResponder()
        }
        
        if textField == threeField && textField.text?.count == 1 {
            fourField.becomeFirstResponder()
        }
        
        if textField == fourField && textField.text?.count == 1 {
            textField.resignFirstResponder()
        }
        
    }
    
    
    
    @objc private func passwordDid(textField:UITextField) {
        
        if oneField.text?.count == 1 && twoField.text?.count ==  1 && threeField.text?.count ==  1 && fourField.text?.count == 1 {
            let code = "\(oneField.text ?? "")\(twoField.text ?? "")\(threeField.text ?? "")\(fourField.text ?? "")"
            print(code)

            let hud = MBProgressHUD.showProgress(self.view)
            BBNetworkTool.loadData(API: UserProviderType.self, target: .retrieveCode(code: code) , cache: true , success: { (json)in
                hud?.hide(animated: true)
                let decoder = JSONDecoder()
                let model = try? decoder.decode(BBUserGeneralModel.self, from: json)
                MBProgressHUD.showTitle(model?.info, to: self.view)
                
                if model?.msg == 1 {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                        self.navigationController?.pushViewController(BBUserUpdatePasswordController(), animated: true)
                    }
                }
                

            }) { (error_code, message) in
                hud?.hide(animated: true)
//                self.addBlankView(blankType: .requestFailed)
                self.addBlankView(BBBlankTypeRequestFailed)
            }


        }
        
    }
}




// MARK: - UITextFieldDelegate
extension BBUserPhonePasswordController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)//获取输入框接收到的文字
        let expression = "^\\d*\\.?\\d{0,2}$"//创建表达式,"*"表示重复0次或更多次，"."表示匹配除换行符以外的任意字符，如果我们想直接匹配"."本身，就得在前边加转义符\\，"?"表示重复0或1次，{0,2}表示重复0或2次，"^","$"分别匹配字符串的开始和末尾，所以整个意思就是，匹配可重复出现的数字+一个"."+两个数字
        let regex = try! NSRegularExpression(pattern: expression, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
        let numberOfMatches = regex.numberOfMatches(in: str, options:.reportProgress, range: NSMakeRange(0, (str as NSString).length))//获取匹配的个数
        return numberOfMatches != 0//如果匹配数量为0则表示不符合输入要求
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == oneField {
            twoField.becomeFirstResponder()
            return false
        }

        if textField == oneField {
            threeField.becomeFirstResponder()
            return false
        }
        
        if textField == threeField {
            fourField.becomeFirstResponder()
            return false
        }
        
        if textField == fourField {
            textField.resignFirstResponder()
            return true
        }
        return true
    }
}

extension BBUserPhonePasswordController : BBTextFieldDelegate{
    
    
    func deleteText(textField: BBTextField) {
        if textField == fourField {
            threeField.becomeFirstResponder()
        }
        
        if textField == threeField {
            twoField.becomeFirstResponder()
        }
        
        if textField == twoField {
            oneField.becomeFirstResponder()
        }

    }
    
}

