//
//  MenuBar.swift
//  Youtube
//
//  Created by win on 3/30/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit
class MenuBar : UIView, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    let imageBars = ["home","trending","subscriptions","account"]
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    let cellId = "cellId"
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectIndexPath, animated: false, scrollPosition: .init(rawValue: 0))
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MenuCell
        cell?.imageView.image = UIImage(named: imageBars[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell?.imageView.tintColor = UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
   
}
