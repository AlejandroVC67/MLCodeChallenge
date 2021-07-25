//
//  ProductListPresenter.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

// MARK: - ProductListDelegate
protocol ProductListDelegate: AnyObject {
    func filterProduct(by query: String)
}

final class ProductListPresenter: NSObject {
    // MARK: - Variables
    weak var delegate: ProductListDelegate?
}

// MARK: - UISearchBarDelegate
extension ProductListPresenter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.filterProduct(by: searchText)
    }
}
