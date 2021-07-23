//
//  MLAnalyticsFactory.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

struct MLAnalyticsFactory {
    static func getLogger(provider: AnalyticsProvider) -> MLAnalyticsProtocol.Type {
        switch provider {
        case .native:
            return MLNativeAnalyticsLogger.self
        }
    }
}
