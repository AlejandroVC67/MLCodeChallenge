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
    case prediction(String)
    case category(String)
    case cateogries
    
    var path: String {
        switch self {
        case .product(let value):
            return String(format: "https://api.mercadolibre.com/sites/MLA/search?q=%@", value)
        case .prediction(let value):
            return String(format: "https://api.mercadolibre.com/sites/MLA/domain_discovery/search?q=$%@", value)
        case .category(let value):
            return String(format: "https://api.mercadolibre.com/sites/MLA/search?category=%@", value)
        case .cateogries:
            return "https://api.mercadolibre.com/sites/MLA/categories"
        }
    }
}
