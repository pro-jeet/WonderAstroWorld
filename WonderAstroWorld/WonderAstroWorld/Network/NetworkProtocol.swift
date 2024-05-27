//
//  NetworkProtocol.swift
//  WonderAstroWorld
//
//  Created by JSharma on 27/05/24.
//

import Foundation

protocol NetworkProtocol {
    func sendDataRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
    func sendRequests<T: Decodable>(type: [T].Type, request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void)
}

