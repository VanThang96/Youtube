//
//  VideoLaucher.swift
//  Youtube
//
//  Created by win on 4/10/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
            let player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player.play()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLaucher: NSObject {
    func showVideoPlayer(){
        if let windown = UIApplication.shared.keyWindow {
            let view = UIView()
            view.frame = CGRect(x: windown.frame.width - 10, y: windown.frame.height - 10, width: 10, height: 10)
            view.backgroundColor = .white
            
            let height = windown.frame.width * 9 / 16
            let videoFrame = CGRect(x: 0, y: 0, width: windown.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoFrame)
            view.addSubview(videoPlayerView)
            
            windown.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = windown.frame
            }) { (completionAnimation) in
                UIApplication.shared.isStatusBarHidden = true
            }
        }
    }
}
