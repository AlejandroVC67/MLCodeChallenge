//
//  ProductDetailPresenter.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation
import UIKit

class ProductDetailPresenter: ObservableObject {
    
    private let productId: String
    @Published private(set) var product: ProductDetail? {
        didSet {
            self.getProductImages()
        }
    }
    @Published private(set) var productImages: [UIImage] = []
    
    private let serviceProvider: ProductServiceRepository.Type
    private var logger: MLAnalyticsProtocol.Type
    
    init(productId: String, serviceProvider: ProductServiceRepository.Type, logger: MLAnalyticsProtocol.Type) {
        self.productId = productId
        self.serviceProvider = serviceProvider
        self.logger = logger
    }
    
    func downloadProductDetail(completion: (() -> Void)? = nil) {
        serviceProvider.searchProductDetail(id: productId) { [weak self] response in
            switch response {
            case .success(let product):
                DispatchQueue.main.async {
                    self?.product = product
                    completion?()
                }
            case .failure(let error):
                self?.logger.log(message: "error: \(error)", type: .error)
            }
        }
    }
    
    func getProductName() -> String {
        return product?.title ?? ""
    }
    
    func getProductQuantity() -> String {
        guard let quantity = product?.availableQuantity else {
            return ""
        }
        
        return String(format: "productlistviewcontroller.productlist.cell.quantity".localized, quantity)
    }
    
    func getProductPrice() -> String {
        guard let currency = product?.currencyID,
              let price = product?.price else {
            return ""
        }
        
        return String(format: "productlistviewcontroller.productlist.cell.price".localized, currency, price)
    }
    
    func getProductCondition() -> String {
        guard let condition = product?.condition else {
            return ""
        }
        
        return String(format: "productlistviewcontroller.productlist.cell.condition".localized, condition)
    }
    
    func getProductAttributes() -> [Attribute] {
        guard let attributes = product?.attributes else {
            return []
        }
        
        return attributes
    }
    
    private func getProductImages() {
        guard let pictures = product?.pictures else {
            return
        }
        serviceProvider.downloadProductPictures(pictures: pictures) { [weak self] response in
            switch response {
            case .success(let images):
                self?.productImages = images
            case .failure(let error):
                self?.logger.log(message: "error: \(error)", type: .error)
            }
        }
    }
}
