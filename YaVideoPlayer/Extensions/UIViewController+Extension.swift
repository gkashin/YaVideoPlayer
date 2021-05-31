//
//  UIViewController+Extension.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 31.05.2021.
//

import UIKit

// MARK: - Alerts
extension UIViewController {
    func showAlert(error: Errors) {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            
            self?.present(alertController, animated: true)
        }
    }
}
