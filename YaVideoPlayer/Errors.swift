//
//  Error.swift
//  YaVideoPlayer
//
//  Created by Георгий Кашин on 31.05.2021.
//

import Foundation

enum Error {
    case invalidUrl
}

// MARK: Error
extension NetworkError: Error {
    var title: String {
        switch self {
        case .unableToLoadStocks: return "Loading stocks failed"
        }
    }
    
    var message: String {
        switch self {
        case .unableToLoadStocks: return "Something went wrong while loading stocks"
        }
    }
    
    var actionTitle: String {
        switch self {
        case .unableToLoadStocks: return "Try again"
        }
    }
}

