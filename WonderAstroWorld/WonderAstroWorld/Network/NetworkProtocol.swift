//
//  NetworkProtocol.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation

/*
 - The NetworkProtocol protocol defines two methods that any conforming type must implement to handle network requests.
 
 ---- sendDataRequest(request:completion:) is a method responsible for sending a data request using URLSession. It takes a URLRequest and a completion handler that returns a Result containing either Data or an Error.
 
 ---- sendRequests(type:request:completion:) is a generic method responsible for sending a request and expects a response of type [T], where T is Decodable. It also uses URLSession to send the request and takes a URLRequest and a completion handler that returns a Result containing either an array of type [T] or an Error.
 */

// Protocol defining methods for network requests
protocol NetworkProtocol {
    
    // Sends a data request using URLSession
    func sendDataRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
    
    // Sends a request and expects a response of type [T], where T is Decodable
    func sendRequests<T: Decodable>(type: [T].Type, request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void)
}

