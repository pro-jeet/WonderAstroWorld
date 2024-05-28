//
//  CacheMemory.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//
/**
 A singleton class responsible for caching UIImage objects using NSCache.

 Usage:
 Example
 let cache = CacheMemory.shared
 cache.set(image, forKey: "exampleKey")
 if let cachedImage = cache.get(forKey: "exampleKey") {
 // Use cachedImage
 
 - Note: NSCache is a mutable collection that stores key-value pairs, similar to NSDictionary. It provides automatic eviction policies, allowing it to automatically remove objects from the cache when memory is low.

 }
 
 */
import Foundation
import SwiftUI


class CacheMemory {
    
    /// Shared instance of CacheMemory, implementing the singleton pattern.
    static let shared = CacheMemory()

    /// The NSCache instance responsible for storing UIImage objects.
    private let cache = NSCache<NSString, UIImage>()

    /**
        Stores the provided image in the cache with the specified key.

        - Parameters:
           - image: The UIImage object to be stored in the cache.
           - key: The unique identifier for the image within the cache.
        */
    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    /**
        Retrieves the image associated with the provided key from the cache.

        - Parameter key: The unique identifier for the desired image within the cache.

        - Returns: The UIImage object associated with the provided key if it exists in the cache, otherwise returns nil.
        */
    func get(forKey key: String) -> UIImage? {
            return cache.object(forKey: key as NSString)
    }
}


