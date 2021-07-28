//
//  ProductDetailPresenter.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

class ProductDetailPresenter {
    
    private let productId: String
    private(set) var product: Product
    
    init(productId: String, serviceProvider: ServiceRepository.Type) {
        self.productId = productId
        self.product = Product(id: "0", title: "Lavadora", price: 200, currencyID: "ARG", availableQuantity: 100, condition: "new", thumbnail: "https://www.tiendamabe.com.co/medias/mabe-lavadora-19kg-blanca-LMA79114SBAB0-derecha.jpg-1200Wx1200H?context=bWFzdGVyfGltYWdlc3wxMDQwMjR8aW1hZ2UvanBlZ3xpbWFnZXMvaDUzL2hlNy84ODc0OTkyMjcxMzkwLmpwZ3wzOTRmOTA3MDc2ZGU0ZjM1NjA0YWU5MzU5ZGQzODJjNTVmMzE0Y2U4NmUwNmNhNWExMWE2NTZkOTZmOTFhNjY2")
    }
    
    func downloadProductDetail() {
        
    }
}
