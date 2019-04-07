//
//  SettingCell.swift
//  Youtube
//
//  Created by win on 4/7/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import UIKit


class SettingCell: BaseCell {
    
    var setting : Setting? {
        didSet{
            lbNameSetting.text = setting?.name.rawValue
            imvSetting.image = UIImage(named: (setting?.imageName)!)?.withRenderingMode(.alwaysTemplate)
        }
    }
    let lbNameSetting : UILabel = {
        let lb = UILabel()
        lb.text = "Setting"
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let imvSetting : UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "setting")
        imv.tintColor = UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)
        imv.contentMode = .scaleAspectFill
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            lbNameSetting.textColor = isHighlighted ? UIColor.white : UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)
            imvSetting.tintColor = isHighlighted ? UIColor.white : UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)
        }
    }
    override func setupViews() {
       
        addSubview(lbNameSetting)
        addSubview(imvSetting)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(20)]-8-[v1]|", views: imvSetting,lbNameSetting)
        addConstraintsWithFormat(format: "V:|[v0]|", views: lbNameSetting)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: imvSetting)
        addConstraint(NSLayoutConstraint(item: imvSetting, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
