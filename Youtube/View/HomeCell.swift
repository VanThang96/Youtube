//
//  FeedCell.swift
//  Youtube
//
//  Created by win on 4/8/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeCell: BaseCell {
    let disposeBag = DisposeBag()
    var videos: Variable<[Video]> = Variable([])
    let cellId = "cellId"
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    override func setupViews() {
        super.setupViews()
        callApi()
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    func callApi(){
        GetData.getVideoList()
            .subscribe(onNext: { (result) in
                self.videos.value = result
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
}
extension HomeCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9/16
        return CGSize(width: frame.width, height: height + 16 + 8 + 44 + 36)
    }
}
extension HomeCell : UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLaucher = VideoLaucher()
        videoLaucher.showVideoPlayer()
    }
}
extension HomeCell : UICollectionViewDataSource{
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.value.count
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? VideoCell
        cell!.video = videos.value[indexPath.item]
        return cell!
    }
}
