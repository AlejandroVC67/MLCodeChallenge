//
//  ServiceRepository.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

typealias ItemsServiceResponse = (Result<Items, ServiceError>) -> Void

/**
 This protocols follows the `Repository design pattern`, it servers as a contract for all ServiceFacades that we can hold in the app, and due to its extension implements a Generic execute function that returns any model as long as it conforms to `Encodable` and `Decodable`.
 */
protocol ServiceRepository {
    static func execute<T>(request: URLRequest, completion: @escaping (Result<T, ServiceError>) -> Void) where T: Codable
    static func getRequest(httpMethod: HTTPMethods, searchType: SearchType) -> URLRequest?
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
    
    static func getRequest(httpMethod: HTTPMethods, searchType: SearchType) -> URLRequest? {
        ServiceRequestBuilder.configureURL(searchType: searchType)
        ServiceRequestBuilder.configure(httpMethod: .get)
        return ServiceRequestBuilder.build()
    }
}
