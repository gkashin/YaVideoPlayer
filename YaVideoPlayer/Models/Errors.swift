//
//  Errors.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 31.05.2021.
//

import Foundation

enum Errors {
    case invalidUrl
}

// MARK: Error
extension Errors: Error {
    var title: String {
        switch self {
        case .invalidUrl: return "Invalid URL"
        }
    }
    
    var message: String {
        switch self {
        case .invalidUrl: return "Something went wrong while loading the URL. Try another one"
        }
    }
}

