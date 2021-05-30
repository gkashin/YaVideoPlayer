//
//  VideoView.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 30.05.2021.
//

import UIKit
import AVFoundation

class VideoView: UIView {
    
    // MARK: Stored Properties
    private let playButton = UIButton(title: "play", titleColor: .white)
    private let fifteenSecondsForwardButton = UIButton(title: "forward", titleColor: .white)
    private let fifteenSecondsBackwardButton = UIButton(title: "back", titleColor: .white)
    
    private var playerLayer: AVPlayerLayer!
    
    private var playAction: (() -> Void)
    private var fifteenSecondsForwardAction: (() -> Void)
    private var fifteenSecondsBackwardAction: (() -> Void)
    
    
    // MARK: Initializers
    init(player: AVPlayer,
         playAction: @escaping () -> Void,
         fifteenSecondsForwardAction: @escaping () -> Void,
         fifteenSecondsBackwardAction: @escaping () -> Void
    ) {
        self.playAction = playAction
        self.fifteenSecondsForwardAction = fifteenSecondsForwardAction
        self.fifteenSecondsBackwardAction = fifteenSecondsBackwardAction
        
        super.init(frame: .zero)
        playerLayer = AVPlayerLayer(player: player)
        layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resize
        
        setupButtons()
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

// MARK: - Private Methods
// MARK: Actions
private extension VideoView {
    @objc func playButtonTapped() {
        playAction()
    }
    
    @objc func fifteenSecondsForwardButtonTapped() {
        fifteenSecondsForwardAction()
    }
    
    @objc func fifteenSecondsBackwardButtonTapped() {
        fifteenSecondsBackwardAction()
    }
}

// MARK: UI
private extension VideoView {
    func setupButtons() {
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        fifteenSecondsForwardButton.addTarget(self, action: #selector(fifteenSecondsForwardButtonTapped), for: .touchUpInside)
        fifteenSecondsBackwardButton.addTarget(self, action: #selector(fifteenSecondsBackwardButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [fifteenSecondsBackwardButton, playButton, fifteenSecondsForwardButton])
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
