//
//  VideoView.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 30.05.2021.
//

import AVFoundation
import UIKit

final class VideoView: UIView {
    
    // MARK: Stored Properties    
    private let controlPanelView: ControlPanelView!
    private let soundControlView: SoundControlView!
    private var playerLayer: AVPlayerLayer!
    
    
    // MARK: Initializers
    init(
        player: AVPlayer,
        playAction: @escaping (_ sender: UIButton) -> Void,
        fifteenSecondsForwardAction: @escaping () -> Void,
        fifteenSecondsBackwardAction: @escaping () -> Void,
        timeSliderAction: @escaping (_ sender: UISlider) -> Void,
        soundSliderAction: @escaping (_ sender: UISlider) -> Void,
        soundSwitchButtonAction: @escaping () -> Void
    ) {
        controlPanelView = ControlPanelView(
            playAction: playAction,
            fifteenSecondsForwardAction: fifteenSecondsForwardAction,
            fifteenSecondsBackwardAction: fifteenSecondsBackwardAction,
            timeSliderAction: timeSliderAction
        )
        
        soundControlView = SoundControlView(soundSliderAction: soundSliderAction, soundSwitchButtonAction: soundSwitchButtonAction)
        
        super.init(frame: .zero)
        playerLayer = AVPlayerLayer(player: player)
        layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resize
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: UIView Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playerLayer.frame = self.bounds
    }
}

// MARK: - Public Methods
// MARK: UI
extension VideoView {
    func updateTimeLabelsAndSlider(currentTime: CMTime, leftTime: CMTime) {
        controlPanelView.updateTimeLabelsAndSlider(currentTime: currentTime, leftTime: leftTime)
    }
    
    func setSliderDuration(duration: CMTime) {
        controlPanelView.setSliderDuration(duration: duration)
    }
    
    func changeSoundSwitchButtonImage(imageName: String) {
        soundControlView.changeSoundSwitchButtonImage(imageName: imageName)
    }
}

// MARK: - Private Methods
// MARK: UI
extension VideoView {
    private func setupUI() {
        setupControlPanelView()
        setupSoundControlView()
    }
    
    private func setupControlPanelView() {
        controlPanelView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(controlPanelView)
        
        NSLayoutConstraint.activate([
            controlPanelView.heightAnchor.constraint(equalToConstant: 40),
            controlPanelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            controlPanelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            controlPanelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    private func setupSoundControlView() {
        soundControlView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(soundControlView)
        
        NSLayoutConstraint.activate([
            soundControlView.heightAnchor.constraint(equalToConstant: 40),
            soundControlView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            soundControlView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            soundControlView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
        ])
    }
}
