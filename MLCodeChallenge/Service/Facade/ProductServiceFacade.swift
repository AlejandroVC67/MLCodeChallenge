//
//  ProductServiceFacade.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

typealias ProductServiceResponse = (Result<ProductDetail, ServiceError>) -> Void
typealias ItemsServiceResponse = (Result<Items, ServiceError>) -> Void

protocol ProductServiceRepository {
    static func searchItem(query: String, completion: @escaping ItemsServiceResponse)
    static func searchProducts(by categoryId: String, completion: @escaping ItemsServiceResponse)
    static func searchProductDetail(id: String, completion: @escaping ProductServiceResponse)
}

struct ProductServiceFacade: ProductServiceRepository, ServiceRepository {
    
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
    
    static func searchProductDetail(id: String, completion: @escaping ProductServiceResponse) {
        guard let request = getRequest(httpMethod: .get, searchType: .productDetail(id)) else {
            completion(.failure(.badRequest))
            return
        }
        
        execute(request: request) { (response: Result<ProductDetail, ServiceError>) in
            switch response {
            case .success(let product):
                completion(.success(product))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
