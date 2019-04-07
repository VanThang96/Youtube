//
//  SettingLaucher.swift
//  Youtube
//
//  Created by win on 4/4/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import  UIKit

struct Setting {
    let name : settingName!
    let imageName : String!
}
enum settingName : String{
    case Setting = "Settings"
    case Term = "Terms & privacy policy"
    case Feedback = "Send Feedback"
    case Help = "Help"
    case Account = "Switch Account"
    case Cancel = "Cancel"
}
class SettingLaucher: NSObject {
    let cellHeight : CGFloat = 50
    var homeViewController = HomeController()
    let settings : [Setting] = {
        return [
            Setting(name: .Setting, imageName: "setting"),
            Setting(name: .Term, imageName: "padlock"),
            Setting(name: .Feedback, imageName: "feedback"),
            Setting(name: .Help, imageName: "help"),
            Setting(name: .Account, imageName: "accountUser"),
            Setting(name: .Cancel, imageName: "close")
        ]
    }()
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    let transparentView = UIView()
    let cellId = "cellId"
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    func showSetting(){
        //show menu
        if let window = UIApplication.shared.keyWindow {
            transparentView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            transparentView.frame = window.frame
            transparentView.alpha = 0
            transparentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(transparentView)
            window.addSubview(collectionView)
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {[weak self] in
                self?.transparentView.alpha = 1
                self?.collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            }, completion: nil)
    
        }
    }
    @objc func handleDismiss(){
        UIView.animate(withDuration: 0.3) {[weak self] in
            self?.transparentView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self?.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            }
        }
    }
}
extension SettingLaucher : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
}
extension SettingLaucher : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SettingCell
        cell?.setting = settings[indexPath.item]
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.transparentView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            }
        }) { (completed: Bool) in
            
            let settingAtIndexPath = self.settings[indexPath.item]
            if settingAtIndexPath.name != .Cancel {
                self.homeViewController.showControllerForSetting(setting : settingAtIndexPath)
            }
            
        }
    }
}
