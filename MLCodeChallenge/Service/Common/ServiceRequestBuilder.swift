//
//  ServiceRequestBuilder.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

/**
 This class is in charge of building the service request.
 - How to use:
    First call the configureURL(searchType: SearchType) this will internally use the path that relates to the specific flow you want to use and format it.
    
    Then call the configure(httpMethod: HTTPMethods) indicating if you want to get or post information.
    
    Finally call the build function and you will have the request created and ready to use.
 */
struct ServiceRequestBuilder: ServiceRequestBuilderProtocol {
    // MARK: - Variables
    static var request: URLRequest?
    
    // MARK: - Internal functions
    
    /**
     Call this function to configure the URL that you need to use for your service call
     - Parameters:
        - searchType: This indicates the flow that you want to use. It could be categories, products, product detail, etc.
     */
    static func configureURL(searchType: SearchType) {
        guard let path = searchType.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        guard let url = URL(string: path) else {
            return
        }
        Self.request = URLRequest(url: url)
    }
    
    /**
     Call this function to configure the HTTP Method of the request.
     - Parameters:
        - httpMethod: The method that you want to use in your request
     */
    static func configure(httpMethod: HTTPMethods) {
        Self.request?.httpMethod = httpMethod.rawValue
    }
    
    /**
     Returns a request with the specified url and http method provided.
     */
    static func build() -> URLRequest? {
        return Self.request
    }
}
