//
//  BBNewsDetailModel.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/7/17.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import Foundation

struct BBNewsDetailModel: Codable{
    let msg: Int
    let info: String
    let typeid: String
    let typename: String
    let aid: String
    let title: String
    let source: String
    let senddate: String
    let body: String
    let litpic: String
    let temparticle: String
    let keywords: String
    var likearticle: [BBNewsChildArcListModel]
}

struct BBNewsDetailLikeArticleModel: Codable{
    
    let id: String
    let title: String
    let writer: String
    let source: String
//    var click: Int
    let litpic: String
    
    let pubdate: String
    let senddate: String
    let description: String
    let arcurl: String
    
//    let msg: Int
//    let info: String
//    let typeid: String
//    let typename: String
//    let aid: String
//    let title: String
//    let source: String
//    let senddate: String
//    let body: String
//    let litpic: String
//    let temparticle: String
//    let keywords: String
//    var likearticle: [BBNewsChildArcListModel]
}




