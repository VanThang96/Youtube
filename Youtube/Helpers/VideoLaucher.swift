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
    var player : AVPlayer?
    let activityIndicator : UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.startAnimating()
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    let pauseAndPlayButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pause"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    let controlContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    let videoLenghtLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "00:00"
        return label
    }()
    let videoCurrentLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "00:00"
        return label
    }()
    let videoSlider : UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        backgroundColor = .black
        
        setupPlayerView()
        
        controlContainerView.frame = frame
        self.addSubview(controlContainerView)
        
        controlContainerView.addSubview(activityIndicator)
        controlContainerView.addSubview(pauseAndPlayButton)
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pauseAndPlayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pauseAndPlayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pauseAndPlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pauseAndPlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlContainerView.addSubview(videoLenghtLabel)
        videoLenghtLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        videoLenghtLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLenghtLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        videoLenghtLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlContainerView.addSubview(videoCurrentLabel)
        videoCurrentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant : 8).isActive = true
        videoCurrentLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        videoCurrentLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoCurrentLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        controlContainerView.addSubview(videoSlider)
        videoSlider.trailingAnchor.constraint(equalTo: videoLenghtLabel.leadingAnchor,constant : -8).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leadingAnchor.constraint(equalTo: videoCurrentLabel.trailingAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    var isPlaying = false
    @objc func handlePause(){
        if isPlaying {
            player?.pause()
            pauseAndPlayButton.setImage(UIImage(named: "play"), for: .normal)
        }else {
            player?.play()
            pauseAndPlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    @objc func handleSliderChange(){
        if let duration = player?.currentItem?.duration{
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completionSeek) in
                
            })
        }
    }
    private func setupPlayerView(){
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            //track player progress
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (time) in
                let seconds = CMTimeGetSeconds(time)
                let secondText = String(format: "%02d", Int(seconds) % 60)
                let minuteText = String(format: "%02d", Int(seconds) / 60)
                self.videoCurrentLabel.text = "\(minuteText):\(secondText)"
                
                //move the slider thumb
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(seconds / durationSeconds)
                }
            })
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicator.stopAnimating()
            controlContainerView.backgroundColor = UIColor.clear
            pauseAndPlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                
                videoLenghtLabel.text = "\(minutesText):\(secondText)"
            }
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
