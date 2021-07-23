//
//  ProductListViewController.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

final class ProductListViewController: UIViewController {
    
    private let listWorker: ProductListWorker
    private let presenter: ProductListPresenter
    private let logger: MLAnalyticsProtocol.Type
    
    init(presenter: ProductListPresenter, listWorker: ProductListWorker, logger: MLAnalyticsProtocol.Type) {
        self.listWorker = listWorker
        self.logger = logger
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
