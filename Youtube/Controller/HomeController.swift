//
//  ViewController.swift
//  Youtube
//
//  Created by win on 3/27/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit


class HomeController: UICollectionViewController {
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Youtube"
        navigationController?.navigationBar.isTranslucent = false
        
        setupCollectionView()
        setupLogoApp()
        setupMenuBar()
        setupNavBarButtons()
    }
    func setupCollectionView(){
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
        }
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.selectedfirstItem()
        mb.homeController = self
        return mb
    }()
    func scrollMenuIndex(menuIndex : Int){
        let index = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: index , at: .centeredHorizontally, animated: true)
    }
    private func setupLogoApp(){
        let titleApp = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 50, height: view.frame.height))
        titleApp.text = "Youtube"
        titleApp.textColor = UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)
        titleApp.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = titleApp
        let youtubeLogo = UIImage(named: "youtube")?.withRenderingMode(.alwaysOriginal)
        let logoBarButtonItem = UIBarButtonItem(image: youtubeLogo, style: .plain, target: self, action:nil)
        logoBarButtonItem.isEnabled = false
        navigationItem.leftBarButtonItem = logoBarButtonItem
    }
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
        
    }
    private func setupNavBarButtons(){
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysTemplate)
        
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action:#selector(handleSearch))
        searchBarButtonItem.tintColor = UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)
        
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action:#selector(handleMore))
        moreBarButtonItem.tintColor = UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem,searchBarButtonItem]
    }
    @objc func handleSearch(){
        print(123)
    }
    lazy var settingLaucher : SettingLaucher = {
        var settingLaucher = SettingLaucher()
        settingLaucher.homeViewController = self
        return settingLaucher
    }()
    @objc func handleMore(){
        //show menu
        settingLaucher.showSetting()
    }
    func showControllerForSetting(setting : Setting){
        let settingViewController = UIViewController()
        settingViewController.navigationItem.title = setting.name.rawValue
        settingViewController.view.backgroundColor = .white
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)]
        navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 99/255, green: 98/255, blue: 99/255, alpha: 1)
        navigationController?.pushViewController(settingViewController, animated: true)
    }
}
extension HomeController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? FeedCell
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarleftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}

