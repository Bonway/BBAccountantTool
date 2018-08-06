//
//  BBUserSetModel.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/26.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import Foundation
struct BBUserSetVersionModel: Codable{
    let msg: Int
    let info: String
    var data: BBUserSetVersionDataModel
}

struct BBUserSetVersionDataModel: Codable{
    let code: String
    let message: String
//    let open: String
//    let tag: String
}
