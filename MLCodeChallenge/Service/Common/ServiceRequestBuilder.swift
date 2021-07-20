//
//  ServiceRequestBuilder.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

struct ServiceRequestBuilder: ServiceRequestBuilderProtocol {
    static var request: URLRequest?
    
    static func configure(url: URL) {
        Self.request = URLRequest(url: url)
    }
    
    static func configure(httpMethod: HTTPMethods) {
        Self.request?.httpMethod = httpMethod.rawValue
    }
    
    static func build() -> URLRequest? {
        return Self.request
    }
}
