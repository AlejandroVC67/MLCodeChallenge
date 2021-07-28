//
//  ProductServiceFacadeMock.swift
//  MLCodeChallengeTests
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit
@testable import MLCodeChallenge

class ProductServiceFacadeMock: ProductServiceRepository {
    static var shouldSearchItemFail: Bool = false
    static var shouldSearchProductFail: Bool = false
    static var shouldSearchProductDetailFail: Bool = false
    static var shouldDownloadProductPicturesFail: Bool = false
    
    static func searchItem(query: String, completion: @escaping ItemsServiceResponse) {
        shouldSearchItemFail ?
            completion(.failure(.badRequest)) :
            completion(.success(getItem()))
    }
    
    static func searchProducts(by categoryId: String, completion: @escaping ItemsServiceResponse) {
        shouldSearchProductFail ? completion(.failure(.badRequest)) : completion(.success(getItem()))
    }
    
    static func searchProductDetail(id: String, completion: @escaping ProductServiceResponse) {
        let productDetail = ProductDetail(id: "", title: "Mock", price: 10, currencyID: "ARG", availableQuantity: 1, condition: "Used", thumbnail: "", attributes: [], pictures: [])
        shouldSearchProductDetailFail ? completion(.failure(.badRequest)) : completion(.success(productDetail))
    }
    
    static func downloadProductPictures(pictures: [Picture], completion: @escaping ProductImagesResponse) {
        guard let image = UIImage(named: "categoryPlaceholder") else {
            completion(.failure(.badRequest))
            return
        }
        shouldDownloadProductPicturesFail ? completion(.failure(.badRequest)) : completion(.success([image]))
    }
    
    static func getItem() -> Items {
        let results = Product(id: "0", title: "Product Mock", price: 100, currencyID: "COP", availableQuantity: 1, condition: "New", thumbnail: "")
        let items = Items(siteID: "", results: [results])
        return items
    }
}
