//
//  BBHomeIndexDataProvider.swift
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/26.
//  Copyright © 2018年 Bonway. All rights reserved.
//

import Foundation
import Moya

let homeIndexProvider = MoyaProvider<HomeIndexType>()

public enum HomeIndexType {
    case tools  //小工具首页
}

//请求配置
extension HomeIndexType: TargetType {
    
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .tools:
            return URL(string: "https://fagui.gaodun.com")!
        }
    }
    
    public var path: String {
        switch self {
        case .tools:
            return "/api/index/tools"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
        case .tools:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    


}
