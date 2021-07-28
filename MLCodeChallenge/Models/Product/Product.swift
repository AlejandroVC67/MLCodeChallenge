//
//  Product.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

struct Product: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id, title, price, condition, thumbnail
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
}
