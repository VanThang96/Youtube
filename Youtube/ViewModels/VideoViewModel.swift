//
//  ViewModel.swift
//  Youtube
//
//  Created by win on 4/1/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class VideoViewModel : NSObject{
    let disposeBag = DisposeBag()
    var videos: Variable<[Video]> = Variable([])
    
    func getData(index: Int) -> Video{
        return videos.value[index]
    }
    
    func getTotal() -> Int{
        return videos.value.count
    }
    override init() {
        super.init()
        
        GetData.getVideoList()
            
            .asObservable()
            .subscribe(onNext: { (result) in
                self.videos.value = result
            })
            .disposed(by: disposeBag)
    }
}
