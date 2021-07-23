//
//  MLAnalyticsProtocol.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation
import OSLog

protocol MLAnalyticsProtocol {
    static func log(message: String, type: OSLogType)
}
