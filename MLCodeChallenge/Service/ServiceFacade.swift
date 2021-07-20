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
        guard let path = String(format: Constants.baseUrl, item).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(.badUrl))
            return
        }
        guard let url = URL(string: path) else {
            completion(.failure(.badUrl))
            return
        }
        
        ServiceRequestBuilder.configure(url: url)
        ServiceRequestBuilder.configure(httpMethod: .get)
        guard let request = ServiceRequestBuilder.build() else {
            completion(.failure(.badRequest))
            return
        }
        
        execute(request: request, completion: completion)
    }
}
