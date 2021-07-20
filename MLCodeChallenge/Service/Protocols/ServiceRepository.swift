//
//  ServiceRepository.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

typealias ItemsServiceResponse = (Result<[Items], ServiceError>) -> Void

protocol ServiceRepository {
    static func getItems(item: String, completion: @escaping ItemsServiceResponse)
    static func execute(request: URLRequest, completion: @escaping ItemsServiceResponse)
}

extension ServiceRepository {
    static func execute(request: URLRequest, completion: @escaping ItemsServiceResponse) {
        let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            do {
                let users = try JSONDecoder().decode([Items].self, from: data)
                completion(.success(users))
            } catch {
                print(error)
                completion(.failure(.unableToParse))
            }
        }
        task.resume()
    }
}
