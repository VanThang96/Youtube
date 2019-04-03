//
//  BaseService.swift
//  Youtube
//
//  Created by win on 4/2/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class BaseService {
    static  func request (_ urlConvertible: URLRequestConvertible) -> Observable<[Video]> {
        return Observable.create ({ observer  in
            let request = AF.request(urlConvertible).responseJSON(completionHandler: { (response) in
                do {
                    switch response.result {
                    case .success:
                        let decoder = JSONDecoder()
                        let video = try decoder.decode(Array<Video>.self, from: response.data!)
                        observer.onNext(video)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(NSError(domain: "myDomain", code: -1, userInfo: nil))
                    }
                } catch let error {
                    observer.onError(error)
                }
            })
            return Disposables.create {
                request.cancel()
            }
        })
    }
}
