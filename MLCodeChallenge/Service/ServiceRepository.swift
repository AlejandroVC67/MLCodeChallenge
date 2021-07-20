//
//  ServiceRepository.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import Foundation

typealias ItemsServiceResponse = (Result<[Items], ServiceError>) -> Void

protocol ServiceRepository {
    static func getContacts(completion: @escaping ItemsServiceResponse)
}
