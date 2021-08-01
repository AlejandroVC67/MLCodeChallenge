//
//  Picture.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

struct Picture: Codable {
    let path: String
    
    enum CodingKeys: String, CodingKey {
        case path = "secure_url"
    }
}
