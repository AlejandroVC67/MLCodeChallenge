//
//  MLAnalyticsProtocol.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation
import OSLog

/**
 This protocol needs to be conformed by all structs or classes of the different AnalyticsProviders that the project may have.
 It holds functions that allows to save all important information about errors or warnings.
 */
protocol MLAnalyticsProtocol {
    static func log(message: String, type: OSLogType)
}
