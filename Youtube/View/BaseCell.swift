//
//  MenuCell.swift
//  Youtube
//
//  Created by win on 3/30/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setupViews(){
        
    }
}
