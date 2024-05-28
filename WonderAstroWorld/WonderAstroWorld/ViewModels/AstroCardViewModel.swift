//
//  AstroCardViewModel.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation
import SwiftUI
import WebKit

/**
 A view model responsible for managing data retrieval for an astronomical card.

 This view model provides a method to fetch data from a given URL and cache it in memory for future use.

 ## Methods:
 - `getData(urlString:key:completion:)`: Fetches data from the specified URL, caches it in memory, and returns it to the completion handler.

 This class utilizes the `CacheMemory` singleton for caching images retrieved from URLs.

 - Note: This class assumes the existence of an `APIClient` class for sending data requests.
*/

class AstroCardViewModel {
    
    // MARK: - Methods
        
        /**
         Fetches data from the specified URL and caches it in memory.

         - Parameters:
            - urlString: The URL string from which to fetch the data.
            - key: The key to associate with the fetched data in the cache.
            - completion: A closure to be called upon completion of the data fetch. It returns the fetched image or an error message.

         This method first checks if the image associated with the provided key exists in the cache. If found, it retrieves the image from the cache and calls the completion handler with the cached image. If not found, it fetches the image from the provided URL asynchronously. Upon successful retrieval, it converts the data to a UIImage object, caches it using the provided key, and calls the completion handler with the image. If any error occurs during the process, it calls the completion handler with nil image and the error message.
        */
    
    func getData(urlString: String, key: String, completion: @escaping (UIImage?, String?) -> Void) {
        
        if let uiIMage = CacheMemory.shared.get(forKey: key) {
            completion(uiIMage, nil)
            
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

