//
//  AstroDetailViewModel.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation
import SwiftUI

/**
 A view model responsible for managing data retrieval for detailed astronomical information.

 This view model provides a method to fetch data from a given URL, with an option to specify whether to retrieve high-definition (HD) images or not.

 ## Properties:
 - `keyHDPrefix`: A string prefix used to differentiate keys for HD images in the cache.

 ## Methods:
 - `getData(urlString:key:isHD:completion:)`: Fetches data from the specified URL and caches it in memory, with an option to retrieve high-definition images.

 This method checks if the specified image is requested in HD. If it is, it appends a prefix to the cache key to distinguish it from standard-definition images. It then checks if the image associated with the modified key exists in the cache. If found, it retrieves the image from the cache and calls the completion handler with the cached image. If not found, it fetches the image from the provided URL asynchronously. Upon successful retrieval, it converts the data to a UIImage object, caches it using the modified key, and calls the completion handler with the image. If any error occurs during the process, it calls the completion handler with nil image and the error message.

 This class utilizes the `CacheMemory` singleton for caching images retrieved from URLs.

 - Note: This class assumes the existence of an `APIClient` class for sending data requests.
*/

class AstroDetailViewModel {
    
    // MARK: - Properties
    
    private let keyHDPrefix = "HD"
    
    // MARK: - Methods
    
    /**
         Fetches data from the specified URL and caches it in memory.

         - Parameters:
            - urlString: The URL string from which to fetch the data.
            - key: The key to associate with the fetched data in the cache.
            - isHD: A boolean value indicating whether to fetch high-definition (HD) images.
            - completion: A closure to be called upon completion of the data fetch. It returns the fetched image or an error message.

         This method checks if the specified image is requested in HD. If it is, it appends a prefix to the cache key to distinguish it from standard-definition images. It then checks if the image associated with the modified key exists in the cache. If found, it retrieves the image from the cache and calls the completion handler with the cached image. If not found, it fetches the image from the provided URL asynchronously. Upon successful retrieval, it converts the data to a UIImage object, caches it using the modified key, and calls the completion handler with the image. If any error occurs during the process, it calls the completion handler with nil image and the error message.
    */
    func getData(urlString: String, key: String, isHD: Bool, completion: @escaping (UIImage?, String?) -> Void) {
        
        if isHD {
            
            let hdKey = keyHDPrefix + key
            
            if let uiImage = CacheMemory.shared.get(forKey: hdKey) {
                completion(uiImage, nil)
                
            } else {
                
                if let url = URL(string: urlString) {
                    
                    let apiClient = APIClient()
                    let request = URLRequest(url: url)

                    apiClient.sendDataRequest(request: request) { result in
                        switch result {
                            case .success(let data):
                            if let uiImage = UIImage(data: data) {
                                CacheMemory.shared.set(uiImage, forKey: hdKey)
                                completion(uiImage, nil)
                            } else {
                                completion(nil, MyError.failedToConvertDataToUIImage.errorDescription)
                            }
                            case .failure(let error):
                            completion(nil, error.localizedDescription)
                        }
                    }
                }
            }
            
        } else {
            
            if let uiImage = CacheMemory.shared.get(forKey: key) {
                completion(uiImage, nil)
                
            } else {
                
                if let url = URL(string: urlString) {
                    
                    let apiClient = APIClient()
                    let request = URLRequest(url: url)

                    apiClient.sendDataRequest(request: request) { result in
                        switch result {
                            case .success(let data):
                            if let uiImage = UIImage(data: data) {
                                CacheMemory.shared.set(uiImage, forKey: key)
                                completion(uiImage, nil)
                            } else {
                                completion(nil, MyError.failedToConvertDataToUIImage.errorDescription)
                            }
                            case .failure(let error):
                            completion(nil, error.localizedDescription)
                        }
                    }
                    
                }
            }
        }
    }
}



