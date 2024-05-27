//
//  CacheMemory.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation
import SwiftUI


class CacheMemory {
    
    static let shared = CacheMemory()

    private let cache = NSCache<NSString, UIImage>()

    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func get(forKey key: String) -> UIImage? {
            return cache.object(forKey: key as NSString)
    }
}


