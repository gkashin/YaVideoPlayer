//
//  UIButton+Extension.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 30.05.2021.
//

import UIKit

extension UIButton {
    convenience init(title: String, titleColor: UIColor, font: UIFont? = .systemFont(ofSize: 16)) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
    }
}
