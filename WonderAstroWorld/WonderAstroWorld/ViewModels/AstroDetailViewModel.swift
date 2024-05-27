//
//  AstroDetailViewModel.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation
import SwiftUI

class AstroDetailViewModel {
    
    func getData(urlString: String, key: String, isHD: Bool, completion: @escaping (UIImage?, String?) -> Void) {
        
        if isHD {
            
            let hdKey = "HD" + key
            
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



