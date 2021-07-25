//
//  ServiceRepository.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

typealias ItemsServiceResponse = (Result<Items, ServiceError>) -> Void
typealias CategoriesServiceResponse = (Result<[Category], ServiceError>) -> Void

/**
 This protocols follows the `Repository design pattern`, it servers as a contract for all ServiceFacades that we can hold in the app, and due to its extension implements a Generic execute function that returns any model as long as it conforms to `Encodable` and `Decodable`.
 */
protocol ServiceRepository {
    static func searchItem(query: String, completion: @escaping ItemsServiceResponse)
    static func categoriesSearch(completion: @escaping CategoriesServiceResponse)
    static func searchCategory(id: String, completion: @escaping (Result<Category, ServiceError>) -> Void)
    static func searchProducts(by categoryId: String, completion: @escaping ItemsServiceResponse)
    
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
