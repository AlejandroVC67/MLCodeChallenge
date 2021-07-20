//
//  Attribute.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

struct Attribute: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case valueName = "value_name"
    }
    
    let name: String
    let valueName: String
}
