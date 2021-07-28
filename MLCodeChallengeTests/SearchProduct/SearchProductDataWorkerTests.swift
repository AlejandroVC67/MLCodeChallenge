//
//  SearchProductDataWorkerTests.swift
//  MLCodeChallengeTests
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import XCTest
@testable import MLCodeChallenge

class SearchProductDataWorkerTests: XCTestCase {
    
    func testUpdateCategories_givenArrayOfCategories_shouldStoreThemInInstanceVariable() {
        // Given
        let worker = SearchProductDataWorker()
        
        // When
        worker.update(categories: CategoryServiceFacadeMock.getCategories())
        
        // Then
        XCTAssertEqual(worker.categories, CategoryServiceFacadeMock.getCategories(), "The categories should be the same")
    }
    
    func testFilterCategories_givenNonEmptyQuery_shouldChangeCategories() {
        // Given
        let worker = SearchProductDataWorker()
        let carsCategory = MLCodeChallenge.Category(id: "1", name: "Cars", picture: "")
        let housesCategory = MLCodeChallenge.Category(id: "2", name: "Houses", picture: "")
        
        worker.update(categories: [carsCategory, housesCategory])
        
        // When
        worker.filterCategories(basedOn: "Houses")
        
        // Then
        XCTAssertEqual(worker.categories, [housesCategory], "There should be a house category")
    }
    
    func testFilterCategories_givenEmptyQuery_shouldChangeCategories() {
        // Given
        let worker = SearchProductDataWorker()
        let carsCategory = MLCodeChallenge.Category(id: "1", name: "Cars", picture: "")
        let housesCategory = MLCodeChallenge.Category(id: "2", name: "Houses", picture: "")
        
        worker.update(categories: [carsCategory, housesCategory])
        
        // When
        worker.filterCategories(basedOn: "")
        
        // Then
        XCTAssertEqual(worker.categories, [carsCategory, housesCategory], "The categories should be the same")
    }
}
