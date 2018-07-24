//
//  BBNewsChildListModel.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/16.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import Foundation

struct BBNewsChildListModel: Codable{
    
    let msg: Int
    let info: String
    let id: String
    let typename: String
    let total: String
    var arcList: [BBNewsChildArcListModel]?
//    enum CodingKeys : String, CodingKey {
//        case msg
//        case info
//        case id = "classId"
//        case typename
//        case data
//    }
    
}
struct BBNewsChildArcListModel: Codable{
    let id: String
    let title: String
    let writer: String
    let source: String
    var click: Int
    let pubdate: String
    let senddate: String
    let description: String
    let arcurl: String
    let imgList: BBNewsChildArcImgListModel

}

struct BBNewsChildArcImgListModel: Codable{
    let count: Int
    let list: [String]
}
