//
//  ServiceError.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

enum ServiceError: Error, LocalizedError {
    case badUrl
    case unableToParse
    case dataError
    case badRequest
    
    var errorDescription: String {
        switch self {
        case .badUrl: return "Failed creating url path"
        case .unableToParse: return "Unable to parse response"
        case .dataError: return "There is an unexpected problem with the data"
        case .badRequest: return "Unable to create the request"
        }
    }
}
