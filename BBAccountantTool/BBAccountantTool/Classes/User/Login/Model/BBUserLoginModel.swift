//
//  BBUserLoginModel.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/23.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import Foundation

struct BBUserLoginModel: Codable{
    let msg: Int
    let info: String
    var data: BBUserLoginModelDataModel
}

struct BBUserLoginModelDataModel: Codable{
    let vip: Int?
}



struct BBUserGeneralModel: Codable{
    let msg: Int
    let info: String
}
