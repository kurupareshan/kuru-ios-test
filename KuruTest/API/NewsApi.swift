//
//  NewsApi.swift
//  KuruTest
//
//  Created by Kuru on 2024-04-30.
//

import Foundation
import Moya

enum NewsAPI {
    case getNewsData
}

extension NewsAPI: TargetType {
    
    public var baseURL: URL {
        guard let url = URL(string: "https://api.restful-api.dev") else { fatalError("base url not configured") }
        return url
    }
    
    public var path: String {
        switch self {
        case .getNewsData:
            return "/objects"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getNewsData:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getNewsData:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        let params = ["Content-Type": "application/json"]
        switch self {
        case .getNewsData:
            return params
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
