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
    case categories
    
    var path: String {
        switch self {
        case .product(let value):
            return String(format: "https://api.mercadolibre.com/sites/MLA/search?q=%@", value)
        case .prediction(let value):
            return String(format: "https://api.mercadolibre.com/sites/MLA/domain_discovery/search?q=$%@", value)
        case .category(let value):
            return String(format: "https://api.mercadolibre.com/categories/%@", value)
        case .categories:
            //"https://api.mercadolibre.com/sites/MLA/categories" bueno
            //https://api.mercadolibre.com/sites/MLA/categories/all dict
            return "https://api.mercadolibre.com/sites/MLA/categories"
        }
    }
}
