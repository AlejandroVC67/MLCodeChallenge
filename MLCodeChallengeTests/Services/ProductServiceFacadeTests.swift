//
//  ProductServiceFacadeTests.swift
//  MLCodeChallengeTests
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import XCTest
@testable import MLCodeChallenge

class ProductServiceFacadeTests: XCTestCase {
    
    func testSearchItem() {
        ProductServiceFacadeMock.searchItem(query: "") { response in
            switch response {
            case .success(let items):
                XCTAssertEqual(items, ProductServiceFacadeMock.getItem(), "The item should be the same")
            case .failure(let error):
                XCTAssertEqual(error, ServiceError.badRequest, "The error should be \(ServiceError.badRequest)")
            }
        }
    }
}
