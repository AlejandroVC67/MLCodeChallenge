//
//  ServiceRepository.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

typealias ItemsServiceResponse = (Result<Items, ServiceError>) -> Void

protocol ServiceRepository {
    static func searchItem(query: String, completion: @escaping ItemsServiceResponse)
    static func predictSearch(query: String, completion: @escaping ItemsServiceResponse)
    static func categorySearch(query: String, completion: @escaping ItemsServiceResponse)
    
    static func execute<T>(request: URLRequest, completion: @escaping (Result<T, ServiceError>) -> Void) where T: Codable
}

extension ServiceRepository {
    static func execute<T>(request: URLRequest, completion: @escaping (Result<T, ServiceError>) -> Void) where T: Codable {
        let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.unableToParse))
                return
            }
            completion(.success(result))
        }
        task.resume()
    }
}
