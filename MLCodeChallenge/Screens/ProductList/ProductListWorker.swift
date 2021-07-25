//
//  ProductListWorker.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

final class ProductListWorker: NSObject {
    
    private enum Constants {
        static let priceFormat = "productlistviewcontroller.productlist.cell.price".localized
        static let quantityFormat = "productlistviewcontroller.productlist.cell.quantity".localized
        static let conditionFormat = "productlistviewcontroller.productlist.cell.condition".localized
    }
    
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
        
        products = storedProducts.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }
}

extension ProductListWorker: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.reuseIdentifier, for: indexPath) as? ProductListTableViewCell,
              let availableQuantity = product.availableQuantity,
              let currencyID = product.currencyID else {
            return UITableViewCell()
        }
        
        let price = String(format: Constants.priceFormat, currencyID, product.price)
        let quantity = String(format: Constants.quantityFormat, availableQuantity)
        let condition = String(format: Constants.conditionFormat, product.condition)
        cell.configureCell(name: product.title, price: price, quantity: quantity, condition: condition, thumbnailPath: product.thumbnail)
        return cell
    }
}

extension ProductListWorker: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
    }
}
