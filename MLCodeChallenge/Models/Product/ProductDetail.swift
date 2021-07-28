//
//  ProductDetail.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

struct ProductDetail: Codable {
    enum CodingKeys: String, CodingKey {
        case id, title, price, condition, thumbnail, attributes, pictures
        case currencyID = "currency_id"
        case availableQuantity = "available_quantity"
    }
    
    let id: String
    let title: String
    let price: Double
    let currencyID: String?
    let availableQuantity: Int?
    let condition: String
    let thumbnail: String
    let attributes: [Attribute]
    let pictures: [Picture]
}
