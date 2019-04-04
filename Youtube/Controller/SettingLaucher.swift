//
//  SettingLaucher.swift
//  Youtube
//
//  Created by win on 4/4/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import  UIKit

class SettingLaucher: NSObject {
    override init() {
        super.init()
    }
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    let transparentView = UIView()
    func showSetting(){
        //show menu
        if let window = UIApplication.shared.keyWindow{
            transparentView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            transparentView.frame = window.frame
            transparentView.alpha = 0
            transparentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(transparentView)
            window.addSubview(collectionView)
            let height: CGFloat = 200
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {[weak self] in
                self?.transparentView.alpha = 1
                self?.collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            }, completion: nil)
    
        }
    }
    @objc func handleDismiss(){
        UIView.animate(withDuration: 0.5) {[weak self] in
            self?.transparentView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self?.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            }
        }
    }
}
