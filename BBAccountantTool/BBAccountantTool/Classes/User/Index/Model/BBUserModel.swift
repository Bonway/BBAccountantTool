//
//  BBUserModel.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/24.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import Foundation

struct BBUserModel: Codable{
    let msg: Int
    let info: String
    var data: BBUserDataModel
}
struct BBUserDataModel: Codable{
    let nickname: String
    let head: String
    let phone: String
    let isvip: Int
}
