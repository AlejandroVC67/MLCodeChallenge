//
//  ProductListWorker.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

final class ProductListWorker: NSObject {
    
    private var products: [Product] = []
    private let storedProducts: [Product]
    
    init(items: Items) {
        self.products = items.results
        self.storedProducts = items.results
    }
    
    func filterProducts(by query: String) {
        if query.isEmpty {
            products = storedProducts
            return
        }
        products = storedProducts.filter { $0.title.contains(query) }
    }
}

extension ProductListWorker: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let product = products[indexPath.row]
        cell.textLabel?.text = product.title
        return cell
    }
}

extension ProductListWorker: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}
