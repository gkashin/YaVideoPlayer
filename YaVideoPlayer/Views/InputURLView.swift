//
//  InputURLView.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 31.05.2021.
//

import UIKit

final class InputURLView: UIView {
    
    private let urlTextField = UITextField()
    private let doneButton = UIButton(title: "Done", titleColor: .black)
    
    private var doneButtonAction: ((_ urlString: String?) -> Void)
    
    init(doneButtonAction: @escaping (_ urlString: String?) -> Void) {
        self.doneButtonAction = doneButtonAction
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI
private extension InputURLView {
    func setupUI() {
        layer.cornerRadius = 20
        backgroundColor = .white
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        urlTextField.placeholder = "Enter video URL"
        urlTextField.borderStyle = .roundedRect
        urlTextField.clearButtonMode = .whileEditing
        urlTextField.text = "https://devstreaming-cdn.apple.com/videos/app_store/app-store-product-page/hls_vod_mvp.m3u8"
        
        let stackView = UIStackView(arrangedSubviews: [urlTextField, doneButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}

// MARK: Actions
private extension InputURLView {
    @objc func doneButtonTapped() {
        guard let urlString = urlTextField.text, urlString != "" else { return }
        
        doneButtonAction(urlString)
    }
}
