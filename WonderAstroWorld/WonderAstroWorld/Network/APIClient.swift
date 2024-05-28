//
//  APIClient.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation

// APIClient class responsible for handling network requests conforming to NetworkProtocol

class APIClient: NetworkProtocol {
    
    // Sends a data request using URLSession
    func sendDataRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        // Code send the network request using URLSession
        URLSession(configuration: .ephemeral).dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(MyError.networkError))
                return
            }
            
            completion(.success(data))

        }.resume()
    }
    
    // Sends a request and expects a response of type [T], where T is Decodable
    func sendRequests<T: Decodable>(type: [T].Type, request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void) {
        // Code send the network request using URLSession
        URLSession(configuration: .ephemeral).dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(MyError.networkError))
                return
            }
            
            do {
                // Decode the received data into an array of type T
                let decodedData = try JSONDecoder().decode([T].self, from: data)
                completion(.success(decodedData))
            } catch {
                // Handle decoding errors
                completion(.failure(error))
            }
        }.resume()
    }
}

