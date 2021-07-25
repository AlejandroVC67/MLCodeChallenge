//
//  MLNativeAnalyticsLogger.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation
import OSLog

/**
 Provider that works as an adapter for the Native logger, it conforms to `MLAnalyticsProtocol` since this protocol is required to be used.
 */
struct MLNativeAnalyticsLogger: MLAnalyticsProtocol {
    static func log(message: String, type: OSLogType) {
        os_log(type, log: .default, "error: \(message)")
    }
}
