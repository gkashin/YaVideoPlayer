//
//  ViewController.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 24.05.2021.
//

import UIKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    
    // MARK: Stored Properties
    private var videoView: VideoView!
    private var player: AVPlayer!
    
    private var isVideoPlaying = false

    
    // MARK: UIViewControllerMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://devstreaming-cdn.apple.com/videos/app_store/app-store-product-page/hls_vod_mvp.m3u8")!
        player = AVPlayer(url: url)
        
        videoView = VideoView(
            player: player,
            playAction: playAction,
            fifteenSecondsForwardAction: fifteenSecondsForwardAction,
            fifteenSecondsBackwardAction: fifteenSecondsBackwardAction
        )
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

// MARK: - Private Methods
// MARK: Actions
private extension VideoPlayerViewController {
    func playAction(_ sender: UIButton) {
        print(#line, #function)
        if isVideoPlaying {
            player.pause()
            isVideoPlaying = false
            sender.setImage(UIImage(systemName: "pause"), for: .normal)
        } else {
            player.play()
            isVideoPlaying = true
            sender.setImage(UIImage(systemName: "play"), for: .normal)
        }
    }
    
    func fifteenSecondsForwardAction() {
        print(#line, #function)
        guard let duration = player.currentItem?.duration else { return }
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 15.0
        
        if newTime < (CMTimeGetSeconds(duration) - 15.0) {
            let time = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
            player.seek(to: time)
        }
    }
    
    func fifteenSecondsBackwardAction() {
        print(#line, #function)
        
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 15.0
        
        if newTime < 0 {
            newTime = 0
        }
        let time = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
        player.seek(to: time)
    }
}

// MARK: UI
private extension VideoPlayerViewController {
    func setupUI() {
        view.backgroundColor = .gray
        
        setupVideoView()
    }
    
    func setupVideoView() {
        videoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoView)
        videoView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            videoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            videoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            videoView.widthAnchor.constraint(equalTo: view.widthAnchor),
            videoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9 / 16),
        ])
    }
}
