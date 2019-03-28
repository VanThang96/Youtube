//
//  ViewController.swift
//  Youtube
//
//  Created by win on 3/27/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Youtube"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleApp = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 50, height: view.frame.height))
        titleApp.text = "Youtube"
        titleApp.textColor = .white
        titleApp.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = titleApp
        
        collectionView.backgroundColor = .white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
}
extension HomeController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9/16
        return CGSize(width: view.frame.width, height: height + 16 + 8 + 44 + 16)
    }
}
extension HomeController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


