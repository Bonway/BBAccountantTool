//
//  UIColor+Extension.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/12.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import UIKit

extension UIColor {
    static var randomColor: UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
    }
    
    
}
