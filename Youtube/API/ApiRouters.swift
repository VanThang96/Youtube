//
//  APIRouters.swift
//  Youtube
//
//  Created by win on 4/1/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouters: URLRequestConvertible {
    
    //The endpoint name
    case getVideoList()
    case getTrendingVideos()
    case getSubscriptionVideos()
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Api.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Api.ContentType.json.rawValue, forHTTPHeaderField: Api.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Api.ContentType.json.rawValue, forHTTPHeaderField: Api.HttpHeaderField.contentType.rawValue)
        let headerParameter: Parameters? = nil
        urlRequest = try URLEncoding.default.encode(urlRequest, with: headerParameter)
        return urlRequest
    }
    
    //MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .getVideoList:
            return .get
        case .getTrendingVideos:
            return .get
        case .getSubscriptionVideos :
            return .get
        }
    }
    var path: String {
        switch self {
        case .getVideoList:
            return "youtubeassets/home.json"
        case .getTrendingVideos:
            return "youtubeassets/trending.json"
        case .getSubscriptionVideos:
            return "youtubeassets/subscriptions.json"
        }
    }
}
