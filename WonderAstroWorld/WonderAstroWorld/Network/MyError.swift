//
//  MyError.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation

// Enum defining custom errors
enum MyError: Error {
    case networkError
    case invalidDate
    case failedToConvertDataToUIImage
    case failedRetrivingAPIKey
    case invalidData
}

// Extension to provide localized descriptions for custom errors
extension MyError: LocalizedError {
    var errorDescription: String? {
        // Provides a localized description for each case
        switch self {
        case .networkError:
           return NSLocalizedString("Network error", comment: "Network error")
        case .invalidDate:
            return NSLocalizedString("Invalid Date", comment: "Invalid Date")
        case .failedToConvertDataToUIImage:
            return NSLocalizedString("Failed to convert to UIImage", comment: "Failed to convert to UIImage")
        case .failedRetrivingAPIKey:
            return NSLocalizedString("Error reading Plist", comment: "API Key Retrival Failure")
        case .invalidData:
            return NSLocalizedString("Invalid Date", comment: "Invalid Date")
        }
    }
}
