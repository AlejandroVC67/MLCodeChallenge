//
//  MLAnalyticsFactory.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

/**
 This struct follows the `Factory design pattern`, it returns the type of a provider based on the specific requirements of the client(views)
 */
struct MLAnalyticsFactory {
    static func getLogger(provider: AnalyticsProvider) -> MLAnalyticsProtocol.Type {
        switch provider {
        case .native:
            return MLNativeAnalyticsLogger.self
        }
    }
}
