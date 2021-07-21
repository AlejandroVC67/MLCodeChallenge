//
//  Prediction.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

struct Prediction: Codable {
    let domainName: String
    let categoryId: String
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case domainName = "domain_name"
    }
}
