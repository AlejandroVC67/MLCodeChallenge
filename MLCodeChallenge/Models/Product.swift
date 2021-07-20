//
//  Product.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

struct Product: Codable {
    enum CodingKeys: String, CodingKey {
        case id, title, price, condition, permalink, thumbnail, installments, attributes
        case siteID = "site_id"
        case currencyID = "currency_id"
        case availableQuantity = "available_quantity"
        case categoryID = "category_id"
    }
    
    let id: String
    let siteID: String
    let title: String
    let price: Int
    let currencyID: String?
    let availableQuantity: Int
    let condition: String
    let permalink: String
    let thumbnail: String
    let installments: Installments?
    let attributes: [Attribute]
    let categoryID: String
}
