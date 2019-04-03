//
//  APIServices.swift
//  Youtube
//
//  Created by win on 4/1/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import Alamofire
struct Api {
    
    //the API base Url
    static let baseUrl = "https://s3-us-west-2.amazonaws.com/"
    
    //Parameters
    struct Parameters {
        
    }
    //Headers
    enum HttpHeaderField : String{
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
   
}
