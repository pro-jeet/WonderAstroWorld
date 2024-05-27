//
//  MyError.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation

enum MyError: Error {
    case networkError
    case invalidDate
    case failedToConvertDataToUIImage
}

extension MyError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .networkError:
           return NSLocalizedString("Network error", comment: "Network error")
        case .invalidDate:
            return NSLocalizedString("Invalid Date", comment: "Invalid Date")
        case .failedToConvertDataToUIImage:
            return NSLocalizedString("Failed to convert to UIImage", comment: "Failed to convert to UIImage")
        }
    }
}
