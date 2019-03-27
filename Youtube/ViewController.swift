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
        collectionView.backgroundColor = .white
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    }
}
extension HomeController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
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
class VideoCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
          setupViews()
    }
    
    let thumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "thumbnail")
        return imageView
    }()
    let userProfileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    let titleLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let subTitleLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView,userProfileImageView,separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        // constrains of labelTitle
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: userProfileImageView, attribute: .trailing, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: thumbnailImageView, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        // constrains of subLabelTitle
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .leading, relatedBy: .equal, toItem: userProfileImageView, attribute: .trailing, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .trailing, relatedBy: .equal, toItem: thumbnailImageView, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
    }
}
extension UIView {
    func addConstraintsWithFormat(format : String, views: UIView...){
        var viewDictionary = [String : UIView]()
        for (index,view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options:  NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: viewDictionary))
       
    }
}
