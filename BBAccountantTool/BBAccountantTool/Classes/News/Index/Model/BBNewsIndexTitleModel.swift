//
//  BBNewsIndexTitleModel.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/12.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import Foundation
struct BBNewsIndexTitleModel: Codable{
    let msg: Int
    let info: String
    var data: [BBNewsIndexTitleDataModel]
}
struct BBNewsIndexTitleDataModel: Codable{
    let tid: String
    let name: String
    let istop: Int
}
