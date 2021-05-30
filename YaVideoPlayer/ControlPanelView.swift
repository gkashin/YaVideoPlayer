//
//  ControlPanelView.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 30.05.2021.
//

import AVFoundation
import UIKit

final class ControlPanelView: UIView {
    
    private let playButton = UIButton(titleColor: .white, imageName: "play")
    private let fifteenSecondsForwardButton = UIButton(titleColor: .white, imageName: "goforward.15")
    private let fifteenSecondsBackwardButton = UIButton(titleColor: .white, imageName: "gobackward.15")
    
    private let timeSlider = UISlider()
    
    private let currentTimeLabel = UILabel(text: "00:00")
    private let leftTimeLabel = UILabel(text: "00:00")
    
    private var playAction: ((_ sender: UIButton) -> Void)
    private var fifteenSecondsForwardAction: (() -> Void)
    private var fifteenSecondsBackwardAction: (() -> Void)
    private var timeSliderAction: ((_ sender: UISlider) -> Void)
    
    init(
        playAction: @escaping (_ sender: UIButton) -> Void,
        fifteenSecondsForwardAction: @escaping () -> Void,
        fifteenSecondsBackwardAction: @escaping () -> Void,
        timeSliderAction: @escaping (_ sender: UISlider) -> Void
    ) {
        self.playAction = playAction
        self.fifteenSecondsForwardAction = fifteenSecondsForwardAction
        self.fifteenSecondsBackwardAction = fifteenSecondsBackwardAction
        self.timeSliderAction = timeSliderAction
        
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods
// MARK: UI
extension ControlPanelView {
    func updateTimeLabelsAndSlider(currentTime: CMTime, leftTime: CMTime) {
        currentTimeLabel.text = currentTime.getTimeString()
        leftTimeLabel.text = leftTime.getTimeString()
        
        timeSlider.value = Float(currentTime.seconds)
    }
    
    func setSliderDuration(duration: CMTime) {
        timeSlider.maximumValue = Float(duration.seconds)
    }
}

// MARK: - Private Methods
// MARK: Actions
private extension ControlPanelView {
    @objc func playButtonTapped(_ sender: UIButton) {
        playAction(sender)
    }
    
    @objc func fifteenSecondsForwardButtonTapped() {
        fifteenSecondsForwardAction()
    }
    
    @objc func fifteenSecondsBackwardButtonTapped() {
        fifteenSecondsBackwardAction()
    }
    
    @objc func timeSliderValueChanged(_ sender: UISlider) {
        timeSliderAction(sender)
    }
}

// MARK: UI
private extension ControlPanelView {
    func setupUI() {
        backgroundColor = .lightGray
        layer.cornerRadius = 10

        setupControls()
    }
    
    func setupControls() {
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        fifteenSecondsForwardButton.addTarget(self, action: #selector(fifteenSecondsForwardButtonTapped), for: .touchUpInside)
        fifteenSecondsBackwardButton.addTarget(self, action: #selector(fifteenSecondsBackwardButtonTapped), for: .touchUpInside)
        
        timeSlider.minimumValue = 0
        timeSlider.addTarget(self, action: #selector(timeSliderValueChanged), for: .valueChanged)
        
        let stackView = UIStackView(arrangedSubviews: [fifteenSecondsBackwardButton, playButton, fifteenSecondsForwardButton, currentTimeLabel, timeSlider, leftTimeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
