//
//  UILabel+Extension.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 30.05.2021.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        self.font = .monospacedDigitSystemFont(ofSize: 12, weight: .regular)
    }
}
