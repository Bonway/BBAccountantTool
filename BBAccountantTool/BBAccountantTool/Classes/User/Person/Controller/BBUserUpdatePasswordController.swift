//
//  BBUserUpdatePasswordController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/26.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

class BBUserUpdatePasswordController: BBGestureBaseController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var againPasswordField: UITextField!
    @IBOutlet weak var sureBtn: UIButton!
    
    var isNoPassword: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordField.addTarget(self, action: #selector(passwordChange(textField:)), for: .allEditingEvents)
        againPasswordField.addTarget(self, action: #selector(passwordChange(textField:)), for: .allEditingEvents)
        setupView()
    }

    private func setupView() {
        
        view.backgroundColor = BBColor(rgbValue: 0xf6f6f6)
        
        navigationItem.title = "修改密码"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navigation_back"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(backClick))
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
extension BBUserUpdatePasswordController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordField.resignFirstResponder()
        againPasswordField.resignFirstResponder()
    }
    
    @IBAction func sureCLick(_ sender: Any) {
        
        
        if isNoPassword {
            let hud = MBProgressHUD.showProgress(view)
            BBNetworkTool.loadData(API: UserProviderType.self, target: .wxPassword(newPwd: passwordField.text ?? "", renewPwd: againPasswordField.text ?? "") , cache: true , success: { (json)in
                hud?.hide(animated: true)
                let decoder = JSONDecoder()
                let model = try? decoder.decode(BBUserGeneralModel.self, from: json)
                MBProgressHUD.showTitle(model?.info, to: self.view)
                
                if model?.msg == 1 {
                    
                    let controller = self.navigationController?.viewControllers[1] as? BBUserPersonController
                    controller?.updatePasswordLabel.text = "已设置"
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                        self.navigationController?.popToViewController(controller!, animated: true)
                    }
                }
            }) { (error_code, message) in
                hud?.hide(animated: true)
//                self.addBlankView(blankType: .requestFailed)
                self.addBlankView(BBBlankTypeRequestFailed)
            }
        }else {
            let hud = MBProgressHUD.showProgress(view)
            BBNetworkTool.loadData(API: UserProviderType.self, target: .updateAgainPassword(tag: "6", newPwd: passwordField.text ?? "", renewPwd: againPasswordField.text ?? "") , cache: true , success: { (json)in
                hud?.hide(animated: true)
                let decoder = JSONDecoder()
                let model = try? decoder.decode(BBUserLoginModel.self, from: json)
                MBProgressHUD.showTitle(model?.info, to: self.view)
                
                if model?.msg == 1 {
                    
                    let controller = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 4] as? BBUserPersonController
                    controller?.updatePasswordLabel.text = "已设置"
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                        self.navigationController?.popToViewController(controller!, animated: true)
                    }
                }
            }) { (error_code, message) in
                hud?.hide(animated: true)
//                self.addBlankView(blankType: .requestFailed)
                self.addBlankView(BBBlankTypeRequestFailed)
            }
        }
        
    }
    
    @objc private func backClick() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func passwordChange(textField:UITextField) {
        if (passwordField.text?.count)! > 0 && (passwordField.text?.count)! > 0{
            sureBtn.isEnabled = true
        }else{
            sureBtn.isEnabled = false
        }
    }
    
}


// MARK: - UITextFieldDelegate
extension BBUserUpdatePasswordController : UITextFieldDelegate{
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)//获取输入框接收到的文字
        
        if str.count > 20  {
            return false
        }
        
        let expression = "^[A-Za-z0-9]*$"
        let regex = try! NSRegularExpression(pattern: expression, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
        let numberOfMatches = regex.numberOfMatches(in: str, options:.reportProgress, range: NSMakeRange(0, (str as NSString).length))//获取匹配的个数
        return numberOfMatches != 0//如果匹配数量为0则表示不符合输入要求
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField ==  passwordField {
            againPasswordField.becomeFirstResponder()
            return false
        }
        
        if textField == againPasswordField {
            textField.resignFirstResponder()
            return true
        }
        return true
    }
}
