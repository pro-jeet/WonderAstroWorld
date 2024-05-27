//
//  AstroCardViewModel.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation
import SwiftUI

class AstroCardViewModel {
    
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
