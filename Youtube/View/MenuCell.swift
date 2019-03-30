//
//  MenuCell.swift
//  Youtube
//
//  Created by win on 3/30/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import UIKit

class MenuCell: BaseCell {
    var imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)
        return iv
    }()
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor(displayP3Red: 239/255, green: 68/255, blue: 48/255, alpha: 1): UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)
        }
    }
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor(displayP3Red: 239/255, green: 68/255, blue: 48/255, alpha: 1): UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)
        }
    }
    
}
