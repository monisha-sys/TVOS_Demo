//
//  PlayerViewController.swift
//  DemoProjectOnTVOS
//
//  Created by Mounika Reddy on 10/02/21.
//

import UIKit
import AVKit
import AVFoundation
import BitmovinPlayer

class PlayerViewController: UIViewController {

    var playerVC = AVPlayerViewController()
    var avPlayer: AVPlayer?
    var playerItem: AVPlayerItem?
    var trackingTime : String?
    var assetTotalDuration : String?
    var preDuration: Float64?

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //Method for playing video in avplayer controller//
    func videoStreaming(video: String) {
        if let url = URL(string:video.replacingOccurrences(of: " ", with: "%20")) {
            self.playerItem = AVPlayerItem(url: url)
            self.avPlayer = AVPlayer(playerItem: self.playerItem)
            self.playerVC.player = self.avPlayer
            self.addChild(playerVC)
            self.view.addSubview(playerVC.view)
            self.playerVC.view.frame = self.view.frame
            self.playerVC.view.tag = 1
            if preDuration != nil && preDuration ?? 0 >= 15 {
                self.avPlayer?.seek(to: CMTimeMakeWithSeconds(preDuration ?? 0.0, preferredTimescale: 1), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero, completionHandler: { (true) in
                    self.playerVC.player?.play()
                })
            }else {
                self.playerVC.player?.play()
            }
        }
    }


}
