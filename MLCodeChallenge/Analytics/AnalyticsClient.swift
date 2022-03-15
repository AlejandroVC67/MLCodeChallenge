//
//  AnalyticsClient.swift
//  MLCodeChallenge
//
//  Created by Diego Alejandro Villa Cardenas on 15/03/22.
//  Copyright © 2022  . All rights reserved.
//

import Foundation
import OSLog

struct AnalyticsClient {
    var log: (_ message: String, _ type: OSLogType) -> Void
}

extension AnalyticsClient {
    static var native = Self(
        log: MLAnalyticsFactory.getLogger(provider: .native).log(message:type:)
    )
}
