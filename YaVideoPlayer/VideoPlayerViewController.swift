//
//  VideoPlayerViewController.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 24.05.2021.
//

import AVFoundation
import UIKit

final class VideoPlayerViewController: UIViewController {
    
    // MARK: Stored Properties
    private var videoView: VideoView!
    private var player: AVPlayer!
    
    private var isVideoPlaying = false

    
    // MARK: UIViewControllerMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://devstreaming-cdn.apple.com/videos/app_store/app-store-product-page/hls_vod_mvp.m3u8")!
        player = AVPlayer(url: url)
        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        addTimeObserver()
        
        videoView = VideoView(
            player: player,
            playAction: playAction,
            fifteenSecondsForwardAction: fifteenSecondsForwardAction,
            fifteenSecondsBackwardAction: fifteenSecondsBackwardAction,
            timeSliderAction: timeSliderAction
        )

        setupUI()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0 {
            let duration = player.currentItem!.duration
            videoView.setSliderDuration(duration: duration)
        }
    }
}

// MARK: - Private Methods
// MARK: Actions
private extension VideoPlayerViewController {
    func playAction(_ sender: UIButton) {
        print(#line, #function)
        if isVideoPlaying {
            player.pause()
            sender.setImage(UIImage(systemName: "play"), for: .normal)
        } else {
            player.play()
            sender.setImage(UIImage(systemName: "pause"), for: .normal)
        }
        isVideoPlaying.toggle()
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
    
    func timeSliderAction(_ sender: UISlider) {
        print(#line, #function)
        
        player.seek(to: CMTimeMake(value: Int64(sender.value * 1000), timescale: 1000))
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

// MARK: Support Methods
private extension VideoPlayerViewController {
    func addTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            guard let currentItem = self?.player.currentItem else { return }
            let duration = currentItem.duration
            let currentTime = currentItem.currentTime()
            let leftTime = duration - currentTime
            self?.videoView.updateTimeLabelsAndSlider(currentTime: currentTime, leftTime: leftTime)
        })
    }
}
