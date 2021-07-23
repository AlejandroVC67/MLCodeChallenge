//
//  ProductListPresenter.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

protocol ProductListDelegate: AnyObject {
    func filterProduct(by query: String)
}

final class ProductListPresenter: NSObject {
    weak var delegate: ProductListDelegate?
}

extension ProductListPresenter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.filterProduct(by: searchText)
    }
}
