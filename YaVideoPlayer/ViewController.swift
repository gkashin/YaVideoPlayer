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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

// MARK: - Private Methods
// MARK: Actions
private extension VideoPlayerViewController {
    func playAction() {
        print(#line, #function)
    }
    
    func fifteenSecondsForwardAction() {
        print(#line, #function)
    }
    
    func fifteenSecondsBackwardAction() {
        print(#line, #function)
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
