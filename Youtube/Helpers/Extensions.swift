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
var imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView{
    func loadImageUsingUrlString(url: String){
        if let imageFromCache = imageCache.object(forKey: url as AnyObject){
            self.image = imageFromCache as? UIImage
            return
        }
        let url = URL(string: url)
        let session = URLSession(configuration: .default)
        session.dataTask(with: url!) { (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                 let imageToCache = UIImage(data: data!)
                imageCache.setObject(imageToCache!, forKey: url as AnyObject)
                self.image = imageToCache
            }
        }.resume()
    }
}
