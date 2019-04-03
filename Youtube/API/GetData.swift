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
}
