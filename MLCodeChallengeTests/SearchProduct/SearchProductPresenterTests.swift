//
//  SearchProductPresenterTests.swift
//  MLCodeChallengeTests
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import XCTest
@testable import MLCodeChallenge

extension CategoryServiceClient {
    static var failing = Self(
        categoriesSearch: {_ in fatalError()},
        searchCategory: {_,_ in fatalError()}
    )
}

class SearchProductPresenterTests: XCTestCase {
    
    let searchProductExpectation = XCTestExpectation(description: "items should match")
    let loadCategoriesExpectation = XCTestExpectation(description: "should load categories or show error")
    let searchProductByCategoryExpectation = XCTestExpectation(description: "should return items or show error")
    
    override func tearDown() {
        super.tearDown()
        ProductServiceFacadeMock.shouldSearchItemFail = false
        CategoryServiceFacadeMock.shouldCategoriesSearchFail = false
        ProductServiceFacadeMock.shouldSearchProductFail = false
    }
    
    override func setUp() {
        environment.categoriesSearchClient = .failing
    }
    
    func testSearchProductByQuery_givenProductServiceProviderAndSearchShouldWork_shouldReturnCorrectItem() {
        // Given
        let presenter = SearchProductPresenter(
            productServiceProvider: ProductServiceFacadeMock.self
        )
        presenter.delegate = self
        
        // When
        presenter.searchProduct(query: "")
        
        // Then
        wait(for: [searchProductExpectation], timeout: 1)
    }
    
    func testSearchProductByQuery_givenProductServiceProviderAndSearchShouldFail_shouldReturnError() {
        // Given
        let presenter = SearchProductPresenter(productServiceProvider: ProductServiceFacadeMock.self)
        presenter.delegate = self
        ProductServiceFacadeMock.shouldSearchItemFail = true
        
        // When
        presenter.searchProduct(query: "")
        
        // Then
        // Jaime estás? D: qué pasó 
        wait(for: [searchProductExpectation], timeout: 1)
    }
    
    func testLoadCategories_givenCategoryServiceProviderAndSearchShouldWork_shouldReturnAllCategoriesCorrectly() {
        class Delegate: SearchProductDelegate {
            var categories = [MLCodeChallenge.Category]()
            
            func show(items: Items) {}
            func reloadTable(categories: [MLCodeChallenge.Category]) {
                self.categories = categories
            }
            func handleError(error: String) { }
            func filterCategories(query: String) {}
        }
        let delegate = Delegate()
        
        // Given
        let expectedCategories = [MLCodeChallenge.Category.init(id: "tests", name: "", picture: nil)]
        environment.categoriesSearchClient.categoriesSearch = {
            $0(.success(expectedCategories))
        }
        
        let presenter = SearchProductPresenter(productServiceProvider: ProductServiceFacadeMock.self)
        presenter.delegate = delegate
        
        // When
        presenter.loadCategories()
        
        // Then
        XCTAssertEqual(delegate.categories, expectedCategories)
    }
    
    func testLoadCategories_givenCategoryServiceProviderAndSearchShouldFail_shouldReturnError() {
        class Delegate: SearchProductDelegate {
            var error = String()
            
            func show(items: Items) {}
            func reloadTable(categories: [MLCodeChallenge.Category]) {}
            func handleError(error: String) { self.error = error }
            func filterCategories(query: String) {}
        }
        let delegate = Delegate()
        
        // Given
        environment.categoriesSearchClient = .error(.badRequest)

        let presenter = SearchProductPresenter(productServiceProvider: ProductServiceFacadeMock.self)
        presenter.delegate = delegate
        
        // When
        presenter.loadCategories()
        
        // Then
        XCTAssertEqual(delegate.error, ServiceError.badRequest.errorDescription)
    }
    
    func testSearchProductByCategory_givenProductServiceProviderAndSearchShouldWork_shouldReturnItem() {
        // Given
        let presenter = SearchProductPresenter(productServiceProvider: ProductServiceFacadeMock.self)
        presenter.delegate = self
        
        // When
        presenter.searchProduct(by: CategoryServiceFacadeMock.getCategory())
        
        // Then
        wait(for: [searchProductByCategoryExpectation], timeout: 1)
    }
    
    func testSearchProductByCategory_givenProductServiceProviderAndSearchShouldFail_shouldReturnError() {
        // Given
        let presenter = SearchProductPresenter(productServiceProvider: ProductServiceFacadeMock.self)
        presenter.delegate = self
        ProductServiceFacadeMock.shouldSearchProductFail = true
        
        // When
        presenter.searchProduct(by: CategoryServiceFacadeMock.getCategory())
        
        // Then
        wait(for: [searchProductByCategoryExpectation], timeout: 1)
    }
}

extension SearchProductPresenterTests: SearchProductDelegate {
    func show(items: Items) {
        // Then
        if !ProductServiceFacadeMock.shouldSearchItemFail {
            XCTAssertEqual(items, ProductServiceFacadeMock.getItem(), "The item should be the same")
            searchProductExpectation.fulfill()
        }
        
        if !ProductServiceFacadeMock.shouldSearchProductFail {
            XCTAssertEqual(items, ProductServiceFacadeMock.getItem(), "The item should be the same")
            searchProductByCategoryExpectation.fulfill()
        }
    }
    
    func reloadTable(categories: [MLCodeChallenge.Category]) {
        if !CategoryServiceFacadeMock.shouldCategoriesSearchFail {
            XCTAssertEqual(categories, CategoryServiceFacadeMock.getCategories(), "The categories should be the same")
            loadCategoriesExpectation.fulfill()
        }
    }
    
    func handleError(error: String) {
        if ProductServiceFacadeMock.shouldSearchItemFail {
            XCTAssertEqual(error, ServiceError.badRequest.errorDescription, "The error should be \(ServiceError.badRequest.errorDescription)")
            searchProductExpectation.fulfill()
        }
        
        if CategoryServiceFacadeMock.shouldCategoriesSearchFail {
            XCTAssertEqual(error, ServiceError.badRequest.errorDescription, "The error should be \(ServiceError.badRequest.errorDescription)")
            loadCategoriesExpectation.fulfill()
        }
        
        if ProductServiceFacadeMock.shouldSearchProductFail {
            XCTAssertEqual(error, ServiceError.badRequest.errorDescription, "The error should be \(ServiceError.badRequest.errorDescription)")
            searchProductByCategoryExpectation.fulfill()
        }
    }
    
    func filterCategories(query: String) {
        // Nothing to do.
    }
}
