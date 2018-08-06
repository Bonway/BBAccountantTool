//
//  BBUserAdviseController.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/26.
//  Copyright © 2018年 Bonway. All rights reserved.
//   

import UIKit

class BBUserAdviseController: BBGestureBaseController {

    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneField.addTarget(self, action: #selector(phoneChange(textField:)), for: .allEditingEvents)
        
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension BBUserAdviseController {
    
    private func setupView() {
        view.backgroundColor = BBColor(rgbValue: 0xf6f6f6)
        navigationItem.title = "意见反馈"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navigation_back"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(backClick))
    }
    @objc private func backClick() {
        navigationController?.popViewController(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentText.resignFirstResponder()
        phoneField.resignFirstResponder()
    }
    
    @objc private func phoneChange(textField:UITextField) {
        
        if let str = textField.text{
            let expression = "^((1[3,5,8][0-9])|(14[5,7])|(17[0,3,6,7,8])|(19[7]))\\d{8}$"//"|"表示什么就不用说了吧，[5|7]表示满足其中任意一个即匹配，数量唯一，"[0-3]"则表示满足0到之间的数字即匹配，数量唯一，[^14]表示匹配除1和4以外的任意字符，这里包括了字母，所以建议弹出键盘类型为数字键盘
            let regex = try! NSRegularExpression(pattern: expression, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
            regex.numberOfMatches(in: str, options:.reportProgress, range: NSMakeRange(0, (str as NSString).length))//获取匹配的个数

        }
        
    }
}

extension BBUserAdviseController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)//获取输入框接收到的文字
        
        if str.count > 11 {
            return false
        }
        
        let expression = "^\\d*\\.?\\d{0,2}$"//创建表达式,"*"表示重复0次或更多次，"."表示匹配除换行符以外的任意字符，如果我们想直接匹配"."本身，就得在前边加转义符\\，"?"表示重复0或1次，{0,2}表示重复0或2次，"^","$"分别匹配字符串的开始和末尾，所以整个意思就是，匹配可重复出现的数字+一个"."+两个数字
        let regex = try! NSRegularExpression(pattern: expression, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
        let numberOfMatches = regex.numberOfMatches(in: str, options:.reportProgress, range: NSMakeRange(0, (str as NSString).length))//获取匹配的个数
        return numberOfMatches != 0//如果匹配数量为0则表示不符合输入要求
    }
    
    @IBAction func sureClick(_ sender: Any) {
        
        let hud = MBProgressHUD.showProgress(view)
        BBNetworkTool.loadData(API: UserProviderType.self, target: .feedback(content: contentText.text ?? "" , contact: phoneField.text ?? "") , cache: true , success: { (json)in
            hud?.hide(animated: true)
            let decoder = JSONDecoder()
            let model = try? decoder.decode(BBUserGeneralModel.self, from: json)
            MBProgressHUD.showTitle(model?.info, to: self.view)
            if model?.msg == 1 {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }) { (error_code, message) in
            hud?.hide(animated: true)
            self.addBlankView(blankType: .requestFailed)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension BBUserAdviseController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            placeholderLabel.isHidden = true
            sureBtn.isEnabled = true
        }else{
            sureBtn.isEnabled = false
            placeholderLabel.isHidden = false
        }
        if textView.text.count > 200  {
            let str = textView.text
            textView.text = String((str?.prefix(200))!)
        }
        numLabel.text = "\(textView.text.count)/200"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.contains("\n") {
            textView.endEditing(true)
            return false
        }
        return true
    }
}

