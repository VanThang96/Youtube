//
//  Extensions.swift
//  Youtube
//
//  Created by win on 3/28/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import UIKit
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
