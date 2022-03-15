//
//  Environment.swift
//  MLCodeChallenge
//
//  Created by Diego Alejandro Villa Cardenas on 15/03/22.
//  Copyright © 2022  . All rights reserved.
//

import Foundation

struct Environment {
    var analyticsClient: AnalyticsClient
    var categorieServiceClient: CategoryServiceClient
}

var environment: Environment = .live

extension Environment {
    static var live = Self(
        analyticsClient: .native,
        categorieServiceClient: .live
    )
}
