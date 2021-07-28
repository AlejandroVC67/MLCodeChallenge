//
//  CategoryServiceFacadeMock.swift
//  MLCodeChallengeTests
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

@testable import MLCodeChallenge

class CategoryServiceFacadeMock: CategoryServiceRepository {
    static var shouldCategoriesSearchFail: Bool = false
    static var shouldSearchCategoryFail: Bool = false
    
    static func categoriesSearch(completion: @escaping CategoriesServiceResponse) {
        
        shouldCategoriesSearchFail ? completion(.failure(.badRequest)) : completion(.success(getCategories()))
    }
    
    static func searchCategory(id: String, completion: @escaping (Result<Category, ServiceError>) -> Void) {
        shouldSearchCategoryFail ? completion(.failure(.badRequest)) : completion(.success(getCategory()))
    }
    
    static func getCategories() -> [Category] {
        let category = Category(id: "1", name: "Mock Category", picture: "")
        return [category]
    }
    
    static func getCategory() -> Category {
        return Category(id: "2", name: "Mock Category 2", picture: "")
    }
}
