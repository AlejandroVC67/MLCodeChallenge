//
//  ServiceFacade.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

struct ServiceFacade: ServiceRepository {
    private enum Constants {
        static let baseUrl = "https://api.mercadolibre.com/sites/MLA/search?q=%@"
    }
    
    static func getItems(item: String, completion: @escaping ItemsServiceResponse) {
        let path = String(format: Constants.baseUrl, item)
        guard let url = URL(string: path) else {
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue
        
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
