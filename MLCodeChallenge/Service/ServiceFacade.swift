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
                    predictSearch(query: query, completion: completion) :
                    completion(.success(items))
            case .failure(_):
                predictSearch(query: query, completion: completion)
            }
        }
    }
    
    static func predictSearch(query: String, completion: @escaping ItemsServiceResponse) {
        guard let request = getRequest(httpMethod: .get, searchType: .prediction(query)) else {
            completion(.failure(.badRequest))
            return
        }
        
        execute(request: request) { (response: Result<[Prediction], ServiceError>) in
            switch response {
            case .success(let predictions):
                guard let firstPrediction = predictions.first else {
                    completion(.failure(.unableToParse))
                    return
                }
                categorySearch(query: firstPrediction.categoryId, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func categorySearch(query: String, completion: @escaping ItemsServiceResponse) {
        guard let request = getRequest(httpMethod: .get, searchType: .category(query)) else {
            completion(.failure(.badRequest))
            return
        }
        
        execute(request: request) { (response: Result<Items, ServiceError>) in
            switch response {
            case .success(let items):
                completion(.success(items))
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
