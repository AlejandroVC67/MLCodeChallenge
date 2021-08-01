//
//  ProductDetailPresenterTests.swift
//  MLCodeChallengeTests
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import XCTest
@testable import MLCodeChallenge

class ProductDetailPresenterTests: XCTestCase {
    
    func testDownloadProductDetail() {
        // Given
        let presenter = ProductDetailPresenter(productId: "", serviceProvider: ProductServiceFacadeMock.self, logger: MLAnalyticsFactory.getLogger(provider: .native))
        
        // When
        presenter.downloadProductDetail {
            // Then
            XCTAssertEqual(presenter.product, ProductServiceFacadeMock.getProductDetail(), "The product detail should be \(ProductServiceFacadeMock.getProductDetail())")
            XCTAssertTrue(ProductServiceFacadeMock.searchProductDetailCalled, "The presenter called the correct function")
        }
    }
    
    func testGetProductName_givenDownloadWorked_shouldReturnProductName() {
        // Given
        let expectedResult = ProductServiceFacadeMock.getProductDetail().title
        let presenter = ProductDetailPresenter(productId: "", serviceProvider: ProductServiceFacadeMock.self, logger: MLAnalyticsFactory.getLogger(provider: .native))
        presenter.downloadProductDetail {
            // When
            let productname = presenter.getProductName()

            // Then
            XCTAssertEqual(productname, expectedResult, "The product name should be \(expectedResult)")
        }
    }

    func testGetProductQuantity_givenDownloadWorked_shouldReturnProductQuantity() {
        // Given
        guard let quantity = ProductServiceFacadeMock.getProductDetail().availableQuantity else {
            XCTFail("There should be a mocked quantity")
            return
        }
        let expectedResult = String(format: "productlistviewcontroller.productlist.cell.quantity".localized, quantity)
        let presenter = ProductDetailPresenter(productId: "", serviceProvider: ProductServiceFacadeMock.self, logger: MLAnalyticsFactory.getLogger(provider: .native))
        presenter.downloadProductDetail {
            // When
            let result = presenter.getProductQuantity()
            
            // Then
            XCTAssertEqual(result, expectedResult, "The product quantity should be \(expectedResult)")
        }
    }
    
    func testGetProductPrice_givenDownloadWorked_shouldReturnProductPrice() {
        // Given
        let product = ProductServiceFacadeMock.getProductDetail()
        guard let currency = product.currencyID else {
            XCTFail("Product should have currency")
            return
        }
        let expectedResult = String(format: "productlistviewcontroller.productlist.cell.price".localized, currency, product.price)
        let presenter = ProductDetailPresenter(productId: "", serviceProvider: ProductServiceFacadeMock.self, logger: MLAnalyticsFactory.getLogger(provider: .native))
        presenter.downloadProductDetail {
            // When
            let result = presenter.getProductPrice()
            
            // Then
            XCTAssertEqual(result, expectedResult, "The product price should be \(expectedResult)")
        }
    }
    
    func testGetProductCondition_givenDownloadWorked_shouldReturnProductCondition() {
        // Given
        let condition = ProductServiceFacadeMock.getProductDetail().condition
        let expectedResult = String(format: "productlistviewcontroller.productlist.cell.condition".localized, condition)
        let presenter = ProductDetailPresenter(productId: "", serviceProvider: ProductServiceFacadeMock.self, logger: MLAnalyticsFactory.getLogger(provider: .native))
        presenter.downloadProductDetail {
            // When
            let result = presenter.getProductCondition()
            
            // Then
            XCTAssertEqual(result, expectedResult, "The result should be \(expectedResult)")
        }
    }
    
    func testGetProductAttributes_givenDownloadWorked_shouldReturnProductAttributes() {
        // Given
        let presenter = ProductDetailPresenter(productId: "", serviceProvider: ProductServiceFacadeMock.self, logger: MLAnalyticsFactory.getLogger(provider: .native))
        presenter.downloadProductDetail {
            // When
            let result = presenter.getProductAttributes()
            
            // Then
            XCTAssertEqual(result, ProductServiceFacadeMock.getProductDetail().attributes ,"The attributes should match")
        }
    }
    
    func testGetProductName_givenDownloadFailed_shouldReturnEmptyString() {
        // Given
        let presenter = ProductDetailPresenter(productId: "", serviceProvider: ProductServiceFacadeMock.self, logger: MLAnalyticsFactory.getLogger(provider: .native))
        presenter.downloadProductDetail()
        
        // When
        let result = presenter.getProductName()
        
        // Then
        XCTAssertTrue(result.isEmpty, "The product name should be empty")
    }
    
    func testGetProductQuantity_givenDownloadFailed_shouldReturnEmptyString() {
        // Given
        let presenter = ProductDetailPresenter(productId: "", serviceProvider: ProductServiceFacadeMock.self, logger: MLAnalyticsFactory.getLogger(provider: .native))
        presenter.downloadProductDetail()
        
        // When
        let result = presenter.getProductQuantity()
        
        // Then
        XCTAssertTrue(result.isEmpty, "The product quanitity should be empty")
    }
    
    func testGetProductPrice_givenDownloadFailed_shouldReturnEmptyString() {
        // Given
        let presenter = ProductDetailPresenter(productId: "", serviceProvider: ProductServiceFacadeMock.self, logger: MLAnalyticsFactory.getLogger(provider: .native))
        presenter.downloadProductDetail()
        
        // When
        let result = presenter.getProductPrice()
        
        // Then
        XCTAssertTrue(result.isEmpty, "The product price should be empty")
    }
    
    func testGetProductCondition_givenDownloadFailed_shouldReturnEmptyString() {
        // Given
        let presenter = ProductDetailPresenter(productId: "", serviceProvider: ProductServiceFacadeMock.self, logger: MLAnalyticsFactory.getLogger(provider: .native))
        presenter.downloadProductDetail()
        
        // When
        let result = presenter.getProductCondition()
        
        // Then
        XCTAssertTrue(result.isEmpty, "The product condition should be empty")
    }
    
    func testGetProductAttributes_givenDownloadFailed_shouldReturnEmptyString() {
        // Given
        let presenter = ProductDetailPresenter(productId: "", serviceProvider: ProductServiceFacadeMock.self, logger: MLAnalyticsFactory.getLogger(provider: .native))
        presenter.downloadProductDetail()
        
        // When
        let result = presenter.getProductAttributes()
        
        // Then
        XCTAssertTrue(result.isEmpty, "The attributes should be empty")
    }
}
