//
//  SoundControlView.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 30.05.2021.
//

import AVFoundation
import UIKit

final class SoundControlView: UIView {
    
    private let soundSlider = UISlider()
    private let soundSwitchButton = UIButton(imageName: "speaker.3")
    
    private var soundSliderAction: ((_ sender: UISlider) -> Void)
    private var soundSwitchButtonAction: (() -> Void)
    
    
    init(
        soundSliderAction: @escaping (_ sender: UISlider) -> Void,
        soundSwitchButtonAction: @escaping () -> Void
    ) {
        self.soundSliderAction = soundSliderAction
        self.soundSwitchButtonAction = soundSwitchButtonAction
        
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods
// MARK: UI
extension SoundControlView {
    func changeSoundSwitchButtonImage(imageName: String) {
        guard let image = UIImage(systemName: imageName) else { return }
        soundSwitchButton.setImage(image, for: .normal)
    }
}

// MARK: - Private Methods
// MARK: Actions
private extension SoundControlView {
    @objc func soundSliderValueChanged(_ sender: UISlider) {
        soundSliderAction(sender)
    }
    
    @objc func soundSwitchButtonTapped() {
        soundSwitchButtonAction()
    }
}

// MARK: UI
private extension SoundControlView {
    func setupUI() {
        backgroundColor = .lightGray
        layer.cornerRadius = 15

        setupControls()
    }
    
    func setupControls() {
        soundSlider.minimumValue = 0
        soundSlider.maximumValue = 1
        soundSlider.value = 1
        soundSlider.addTarget(self, action: #selector(soundSliderValueChanged), for: .valueChanged)
        soundSwitchButton.addTarget(self, action: #selector(soundSwitchButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [soundSlider, soundSwitchButton])
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

