//
//  ServiceError.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

/**
 The multiple types of Service Error that can be generated while creating and executing a service call.
 */
enum ServiceError: Error, LocalizedError {
    case badUrl
    case unableToParse
    case dataError
    case badRequest
    case emptyResponse
    
    var errorDescription: String {
        switch self {
        case .badUrl: return "Failed creating url path"
        case .unableToParse: return "Unable to parse response"
        case .dataError: return "There is an unexpected problem with the data"
        case .badRequest: return "Unable to create the request"
        case .emptyResponse: return "We could not find any products that match your search"
        }
    }
}
