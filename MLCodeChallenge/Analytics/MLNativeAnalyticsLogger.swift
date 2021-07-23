//
//  MLNativeAnalyticsLogger.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation
import OSLog

struct MLNativeAnalyticsLogger: MLAnalyticsProtocol {
    static func log(message: String, type: OSLogType) {
        os_log(type, log: .default, "error: \(message)")
    }
}
