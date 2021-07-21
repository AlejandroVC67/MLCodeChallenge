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
    
    private enum Constants {
        static let baseUrl = "https://api.mercadolibre.com/sites/MLA/search?q=%@"
        static let predictSearchUrl = "https://api.mercadolibre.com/sites/MLA/domain_discovery/search?q=$%@"
        static let categorySearchUrl = "https://api.mercadolibre.com/sites/MLA/search?category=%@"
    }
    
    static func configureURL(searchType: SearchType) {
        guard let path = searchType.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        guard let url = URL(string: path) else {
            return
        }
        Self.request = URLRequest(url: url)
    }
    
    static func configure(httpMethod: HTTPMethods) {
        Self.request?.httpMethod = httpMethod.rawValue
    }
    
    static func build() -> URLRequest? {
        return Self.request
    }
}
