//
//  SearchType.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

enum SearchType {
    case product(String)
    case category(String)
    case categories
    case categoryProduct(String)
    
    var path: String {
        switch self {
        case .product(let value):
            return String(format: "https://api.mercadolibre.com/sites/MLA/search?q=%@", value)
        case .category(let value):
            return String(format: "https://api.mercadolibre.com/categories/%@", value)
        case .categories:
            return "https://api.mercadolibre.com/sites/MLA/categories"
        case .categoryProduct(let categoryId):
            return String(format: "https://api.mercadolibre.com/sites/MLA/search?category=%@", categoryId)
        }
    }
}
