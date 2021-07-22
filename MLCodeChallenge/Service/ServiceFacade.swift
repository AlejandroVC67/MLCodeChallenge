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
        guard let request = getRequest(httpMethod: .get, searchType: .categories) else {
            completion(.failure(.badRequest))
            return
        }
        
//        execute(request: request) { (response: Result<[String: Category], ServiceError>) in
//            switch response {
//            case .success(let categories):
//
//                let result = Array(categories.values)
//                completion(.success(result))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
        
        execute(request: request) { (response: Result<[Category], ServiceError>) in
            var result: [Category] = []
            switch response {
            case .success(let categories):
                categories.forEach {
                    searchCategory(id: $0.id) { response in
                        switch response {
                        case .success(let category):
                            result.append(category)
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    completion(.success(result))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func searchCategory(id: String, completion: @escaping (Result<Category, ServiceError>) -> Void) {
        guard let request = getRequest(httpMethod: .get, searchType: .category(id)) else {
            completion(.failure(.badRequest))
            return
        }
        
        execute(request: request) { (response: Result<Category, ServiceError>) in
            switch response {
            case .success(let category):
                completion(.success(category))
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
