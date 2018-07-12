//
//  String+Extension.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/6.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import Foundation

// MARK: - 返回MD5字符串
extension String  {
    var MD5String: String {
        let cStrl = cString(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer)
        var md5String = ""
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx])
            md5String.append(obcStrl)
        }
        free(buffer)
        return md5String
    }
    
    var tokenString: String {
        var tokenBeforeString = ""
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let strNowTime = timeFormatter.string(from: date as Date) as String
        tokenBeforeString = "uLUw5J0SwQ\(strNowTime)\(self)"
        return tokenBeforeString.MD5String
    }
}
