//
//  ProductListWorker.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

// MARK: - ProductListWorkerDelegate
protocol ProductListWorkerDelegate: AnyObject {
    func checkDetail(of productId: String)
    func showEmptyView()
    func removeEmptyView()
}

final class ProductListWorker: NSObject {
    
    // MARK: - Constants
    private enum Constants {
        static let priceFormat = "productlistviewcontroller.productlist.cell.price".localized
        static let quantityFormat = "productlistviewcontroller.productlist.cell.quantity".localized
        static let conditionFormat = "productlistviewcontroller.productlist.cell.condition".localized
    }
    
    // MARK: - Variables
    private var products: [Product] = []
    private let storedProducts: [Product]
    weak var delegate: ProductListWorkerDelegate?
    
    // MARK: - Init
    init(items: Items) {
        self.products = items.results
        self.storedProducts = items.results
    }
    
    // MARK: - Internal functions
    func filterProducts(by query: String) {
        if query.isEmpty {
            products = storedProducts
            delegate?.removeEmptyView()
            return
        }
        
        products = storedProducts.filter { $0.title.localizedCaseInsensitiveContains(query) }
        products.isEmpty ? delegate?.showEmptyView() : delegate?.removeEmptyView()
    }
}

// MARK: - UITableViewDataSource
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

// MARK: - UITableViewDelegate
extension ProductListWorker: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        delegate?.checkDetail(of: product.id)
    }
}
