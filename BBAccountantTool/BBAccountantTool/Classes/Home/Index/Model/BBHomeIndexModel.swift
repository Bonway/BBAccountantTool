//
//  BBHomeIndexModel.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/26.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import Foundation

struct BBHomeIndexModel: Codable{
    let msg: Int
    let info: String
    var data: [BBHomeIndexDataModel]
}

struct BBHomeIndexDataModel: Codable{
    let typename: String
    var child: [BBHomeIndexDataChildModel]
}

struct BBHomeIndexDataChildModel: Codable{
    let title: String
    let iconurl: String
    let h5url: String
    let sharetitle: String
    let description: String
}
