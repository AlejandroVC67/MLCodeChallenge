//
//  Items.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

struct Items: Codable {
    let siteID: String
    let results: [Product]

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case results
    }
}

extension Items: Equatable {
    static func == (lhs: Items, rhs: Items) -> Bool {
        return lhs.results == rhs.results
    }
}
