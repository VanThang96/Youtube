//
//  SubcriptionCell.swift
//  Youtube
//
//  Created by win on 4/9/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class SubcriptionCell: HomeCell {
    override func callApi() {
        GetData.getSubscriptionVideos()
            .subscribe(onNext: { (result) in
                self.videos.value = result
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}
