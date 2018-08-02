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
    var city: String
    var province: String
    let birthday: String
    let viptype: String
    let viptime: String
    let password: Int
    let viptypeid: Int
    let shareday: String
}

struct BBUserPersonAddressModel: Codable{
    let msg: Int
    let info: String
    var data: [BBUserPersonAddressDataModel]
}
struct BBUserPersonAddressDataModel: Codable{
    let id: String
    let name: String
    var second: [BBUserPersonAddressSecondDataModel]
}
struct BBUserPersonAddressSecondDataModel: Codable{
    let id: String
    let name: String
}
