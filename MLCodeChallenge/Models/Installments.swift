//
//  Installments.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

struct Installments: Codable {
    enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyID = "currency_id"
    }
    
    let quantity: Int
    let amount: Double
    let rate: Double
    let currencyID: String
}
