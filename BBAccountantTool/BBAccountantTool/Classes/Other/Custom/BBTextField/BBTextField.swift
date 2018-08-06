//
//  BBTextField.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/8/6.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit



@objc protocol BBTextFieldDelegate {
    func deleteText(textField:BBTextField)
}


class BBTextField: UITextField {

    
    var bbDelegate: BBTextFieldDelegate?
    
    
    override func deleteBackward() {
        super.deleteBackward()
        
//        if self.bbDelegate. {
//            <#code#>
//        }
        
        bbDelegate?.deleteText(textField: self)
        
//        if self.bbDelegate?.responds(to: #selector(deleteText)) {
//            self.bbDelegate?.deleteText(textField: self)
//        }
        print("hhaha")
        
    }
}
