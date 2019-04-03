//
//  VideoCell.swift
//  Youtube
//
//  Created by win on 3/28/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit


class VideoCell : BaseCell {
    var video : Video?{
        didSet{
            setupThumbnailImage()
            setupProfileImage()
            titleLabel.text = video?.title
            if let channelName = video?.channel[0].name, let numberOfViews = video?.number_of_views  {
                let number = NSNumber(value: numberOfViews)
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                subTitleLabel.text = "\(channelName) •  \(numberFormatter.string(from: number)!) • 2 year ago"
            }
        }
    }
    let thumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "thumbnail")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let userProfileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.image = UIImage(named: "profile")
        imageView.layer.cornerRadius = 22
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Avengers: Endgame - Official Trailer"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let subTitleLabel : UITextView = {
        let textview = UITextView()
        textview.text = "Marvel Entertaiment • 79 milion views • 1 month ago "
        textview.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textview.textColor = .lightGray
        textview.isEditable = false
        textview.translatesAutoresizingMaskIntoConstraints = false
        return textview
    }()
    let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    override func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-24-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,userProfileImageView,separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        // constrains of labelTitle
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: userProfileImageView, attribute: .trailing, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: thumbnailImageView, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
        
        // constrains of subLabelTitle
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .leading, relatedBy: .equal, toItem: userProfileImageView, attribute: .trailing, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .trailing, relatedBy: .equal, toItem: thumbnailImageView, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    private func setupThumbnailImage(){
        if let thumbnailImageUrl = video?.thumbnail_image_name{
            thumbnailImageView.loadImageUsingUrlString(url: thumbnailImageUrl)
        }
    }
    private func setupProfileImage(){
        if let profileImageUrl = video?.channel[0].profile_image_name{
            userProfileImageView.loadImageUsingUrlString(url: profileImageUrl)
        }
    }
}
