//
//  ProductListWorkerTests.swift
//  MLCodeChallengeTests
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import XCTest
@testable import MLCodeChallenge

class ProductListWorkerTests: XCTestCase {
    
    func testInit_givenItems_shouldStoreInAnInstanceVariable() {
        // Given
        let items = ProductServiceFacadeMock.getItem()
        
        // When
        let worker = ProductListWorker(items: items)
        
        // Then
        XCTAssertEqual(worker.products, items.results, "The products should be the same")
    }
    
    func testFilterProducts_givenNonEmptyQuery_shouldChangeProducts() {
        // Given
        let firstItem = Product(id: "0", title: "Product Mock", price: 100, currencyID: "COP", availableQuantity: 1, condition: "New", thumbnail: "")
        let secondItem = Product(id: "1", title: "Second Product", price: 100, currencyID: "COP", availableQuantity: 1, condition: "New", thumbnail: "")
        let items = Items(siteID: "", results: [firstItem, secondItem])
        let worker = ProductListWorker(items: items)
        
        // When
        worker.filterProducts(by: "Product Mock")
        
        // Then
        XCTAssertEqual(worker.products, [firstItem], "The only item should be \(firstItem)")
    }
    
    func testFilterProducts_givenEmptyQuery_shouldChangeProducts() {
        // Given
        let firstItem = Product(id: "0", title: "Product Mock", price: 100, currencyID: "COP", availableQuantity: 1, condition: "New", thumbnail: "")
        let secondItem = Product(id: "1", title: "Second Product", price: 100, currencyID: "COP", availableQuantity: 1, condition: "New", thumbnail: "")
        let items = Items(siteID: "", results: [firstItem, secondItem])
        let worker = ProductListWorker(items: items)
        
        // When
        worker.filterProducts(by: "")
        
        // Then
        XCTAssertEqual(worker.products, [firstItem, secondItem], "The items should be the same")
    }
}
