//
//  ServiceRequestBuilderProtocol.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

protocol ServiceRequestBuilderProtocol {
    static var request: URLRequest? { get set }
    static func configureURL(searchType: SearchType)
    static func configure(httpMethod: HTTPMethods)
    static func build() -> URLRequest?
}
