//
//  CategoryServiceFacade.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

//state - actions - environment

// title
// subtitle
// image

//struct ErrorMessageBox {
//    var title: String
//    var subtitle: String
//    var imageUrl: URL
//}

final class ViewModel {
    // State
    private(set) var error: Error? {
        didSet { onError?() }
    }
    private(set) var categories: [Category] = [] {
        didSet { onCategoriesChange?() }
    }
    var onError: (() -> Void)?
    var onCategoriesChange: (() -> Void)?
    
    // Action
    func loadCategories() {
        environment.categoriesSearchClient.categoriesSearch { [weak self] in
            switch $0 {
            case .success(let categories):
                self?.categories = categories
            case .failure(let error):
                self?.error = error
            }
        }
    }
}

// Test -> initial state , action , result vs expected
// reemplazar el nodo de environment que mutaria mi estado para tener un test deterministico.

typealias CategoriesServiceResponse = (Result<[Category], ServiceError>) -> Void

protocol CategoryServiceRepository {
    static func categoriesSearch(completion: @escaping CategoriesServiceResponse) -> Void
    static func searchCategory(id: String, completion: @escaping (Result<Category, ServiceError>) -> Void) -> Void
}
extension CategoryServiceFacade: CategoryServiceRepository {}

protocol NewProtocol {
    var name: String { get }
    // func name() -> String
    static func name() -> String
}

struct NewStruct<T> {
    var name: (T) -> String
    var nameStatic: () -> String
}

//public protocol Equatable {
//    static func == (lhs: Self, rhs: Self) -> Bool
//}
struct Equalability<T> {
    var equal: (_ lhs: T, _ rhs: T) -> Bool
}
extension Equalability where T == Int {
    static var int = Self { lhs, rhs in lhs == rhs }
}

//public protocol CustomStringConvertible {
//    var description: String { get }
//}
struct Describlable<T> {
    var decription: (T) -> String
}

struct User: CustomStringConvertible {
    var name: String
    var password: String
    
    var description: String { name + password }
}

extension Describlable where T == User {
    static var secure = Self {
        $0.name + $0.password.map { _ in "*" }
    } // jaime *******
    static var regular = Self { $0.name + $0.password }
    static var urlQuery = Self { "?name=\($0.name),password=\($0.password)" }
}

struct CategoryServiceClient {
    var categoriesSearch: (_ completion: @escaping CategoriesServiceResponse) -> Void
    var searchCategory: (_ id: String, _ completion: @escaping (Result<Category, ServiceError>) -> Void) -> Void
}

extension CategoryServiceClient {
    static var live = Self(
        categoriesSearch: CategoryServiceFacade.categoriesSearch(completion:),
        searchCategory: CategoryServiceFacade.searchCategory(id:completion:)
    )
}

struct CategoryServiceFacade: ServiceRepository {
    
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
}
