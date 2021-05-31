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
    private var inputURLView: InputURLView!
    private var player: AVPlayer!
    
    private var isVideoPlaying = false
    private var previousVolume: Float = 1
    
    
    // MARK: UIViewControllerMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputURLView = InputURLView(doneButtonAction: doneButtonTapped)
        setupUI()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0 {
            let duration = player.currentItem!.duration
            videoView.setSliderDuration(duration: duration)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - Private Methods
// MARK: Actions
private extension VideoPlayerViewController {
    func playAction(_ sender: UIButton) {
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
        guard let duration = player.currentItem?.duration else { return }
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 15.0
        
        if newTime < (CMTimeGetSeconds(duration) - 15.0) {
            let time = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
            player.seek(to: time)
        }
    }
    
    func fifteenSecondsBackwardAction() {
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 15.0
        
        if newTime < 0 {
            newTime = 0
        }
        let time = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
        player.seek(to: time)
    }
    
    func timeSliderAction(_ sender: UISlider) {
        player.seek(to: CMTimeMake(value: Int64(sender.value * 1000), timescale: 1000))
    }
    
    func soundSliderAction(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    func soundSwitchButtonAction() {
        if !player.isMuted {
            player.isMuted = true
            videoView.changeSoundSwitchButtonImage(imageName: "speaker.slash")
        } else {
            player.isMuted = false
            videoView.changeSoundSwitchButtonImage(imageName: "speaker.3")
        }
    }
    
    @objc func doneButtonTapped(_ urlString: String?) {
        guard let urlString = urlString, urlString != "" else { return }
        guard let url = URL(string: urlString) else {
            showAlert(error: .invalidUrl)
            return
        }
        inputURLView.removeFromSuperview()
        
        setupPlayer(with: url)
        
        setupVideoView()
    }
}

// MARK: UI
private extension VideoPlayerViewController {
    func setupUI() {
        view.backgroundColor = .gray
        
        setupInputURLView()
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
    
    func setupInputURLView() {
        inputURLView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputURLView)

        NSLayoutConstraint.activate([
            inputURLView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            inputURLView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputURLView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputURLView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
    
    func setupPlayer(with url: URL) {
        player = AVPlayer(url: url)
        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        addTimeObserver()
    
        videoView = VideoView(
            player: player,
            playAction: playAction,
            fifteenSecondsForwardAction: fifteenSecondsForwardAction,
            fifteenSecondsBackwardAction: fifteenSecondsBackwardAction,
            timeSliderAction: timeSliderAction,
            soundSliderAction: soundSliderAction,
            soundSwitchButtonAction: soundSwitchButtonAction
        )
    }
}
