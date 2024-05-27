//
//  APIClient.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation

protocol NetworkProtocol {
    func sendDataRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
    func sendRequests<T: Decodable>(type: [T].Type, request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void)
}

class APIClient: NetworkProtocol {
    func sendDataRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        // Implement logic to send the network request using URLSession
        URLSession(configuration: .ephemeral).dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Network error", code: 1, userInfo: nil)))
                return
            }
            
            completion(.success(data))

        }.resume()
    }
    
    func sendRequests<T: Decodable>(type: [T].Type, request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void) {
        // Implement logic to send the network request using URLSession
        URLSession(configuration: .ephemeral).dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Network error", code: 1, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([T].self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

