//
//  BBUserPersonModel.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/25.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import Foundation
struct BBUserPersonModel: Codable{
    let msg: Int
    let info: String
    var data: BBUserPersonDataModel
}
struct BBUserPersonDataModel: Codable{
    let nickname: String
    let head: String
    let sex: String
    let phone: String
    let city: String
    let province: String
    let birthday: String
    let viptype: String
    let viptime: String
    let password: Int
    let viptypeid: Int
    let shareday: String
}

