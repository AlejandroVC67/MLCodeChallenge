//
//  ServiceFacade.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

struct ServiceFacade: ServiceRepository {
    
    static func searchItem(query: String, completion: @escaping ItemsServiceResponse) {
        
        guard let request = getRequest(httpMethod: .get, searchType: .product(query)) else {
            completion(.failure(.badRequest))
            return
        }
        
        execute(request: request) { (response: Result<Items, ServiceError>) in
            switch response {
            case .success(let items):
                items.results.isEmpty ?
                    completion(.failure(.emptyResponse)) :
                    completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func categoriesSearch(completion: @escaping CategoriesServiceResponse) {
        guard let request = getRequest(httpMethod: .get, searchType: .cateogries) else {
            completion(.failure(.badRequest))
            return
        }
        
        execute(request: request) { (response: Result<[Category], ServiceError>) in
            switch response {
            case .success(let categories):
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func getRequest(httpMethod: HTTPMethods, searchType: SearchType) -> URLRequest? {
        ServiceRequestBuilder.configureURL(searchType: searchType)
        ServiceRequestBuilder.configure(httpMethod: .get)
        return ServiceRequestBuilder.build()
    }
}
