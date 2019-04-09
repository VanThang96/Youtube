//
//  GetData.swift
//  Youtube
//
//  Created by win on 4/2/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import RxSwift

class GetData: BaseService {
    static func getVideoList() -> Observable<[Video]> {
        return request(APIRouters.getVideoList()).map({data in
            return data
        })
    }
    static func getTrendingVideo() -> Observable<[Video]> {
        return request(APIRouters.getTrendingVideos()).map({ data in
            return data
        })
    }
    static func getSubscriptionVideos() -> Observable<[Video]>{
        return request(APIRouters.getSubscriptionVideos()).map({ data in
            return data
        })
    }
}
