//
//  ViewController.swift
//  Youtube
//
//  Created by win on 3/27/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {
    
    let videos : [Video] = {
        var marvelChannel = Channel()
        marvelChannel.name = "Marvel Entertaiment"
        marvelChannel.profileImageName = "profile"
        
        var endgameTrailer = Video()
        endgameTrailer.thumnailImage = "endgame1"
        endgameTrailer.title = "Marvel Studio Avengers: Endgame - Official Trailer"
        endgameTrailer.numberOfViews = 23000000
        endgameTrailer.channel = marvelChannel
        return [endgameTrailer]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Youtube"
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView.backgroundColor = .white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupLogoApp()
        setupMenuBar()
        setupNavBarButtons()
    }
    let menuBar : MenuBar = {
        let mb = MenuBar()
        return mb
    }()
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
    @objc func handleMore(){
        print(123)
    }
}
extension HomeController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9/16
        return CGSize(width: view.frame.width, height: height + 16 + 8 + 44 + 36)
    }
}
extension HomeController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? VideoCell
        cell!.video = videos[indexPath.item]
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


