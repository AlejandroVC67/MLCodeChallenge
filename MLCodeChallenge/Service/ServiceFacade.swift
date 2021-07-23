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
        let dispatchGroup = DispatchGroup()
        guard let request = getRequest(httpMethod: .get, searchType: .categories) else {
            completion(.failure(.badRequest))
            return
        }

        execute(request: request) { (response: Result<[Category], ServiceError>) in
            var result: [Category] = []
            switch response {
            case .success(let categories):
                categories.forEach {
                    dispatchGroup.enter()
                    searchCategory(id: $0.id) { response in
                        switch response {
                        case .success(let category):
                            result.append(category)
                            dispatchGroup.leave()
                        case .failure(let error):
                            completion(.failure(error))
                            dispatchGroup.leave()
                        }
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    completion(.success(result))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func searchProducts(by categoryId: String, completion: @escaping ItemsServiceResponse) {
        guard let request = getRequest(httpMethod: .get, searchType: .categoryProduct(categoryId)) else {
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
