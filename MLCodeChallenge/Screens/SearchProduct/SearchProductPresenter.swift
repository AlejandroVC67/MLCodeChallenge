//
//  SearchProductPresenter.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

// MARK: - SearchProductDelegate
protocol SearchProductDelegate: AnyObject {
    func show(items: Items)
    func reloadTable(categories: [Category])
    func handleError(error: String)
    func filterCategories(query: String)
}

final class SearchProductPresenter: NSObject {
    // MARK: - Variables
    weak var delegate: SearchProductDelegate?
    
    private let productServiceProvider: ProductServiceRepository.Type
    private let categoryServiceProvider: CategoryServiceRepository.Type
    
    // MARK: - Init
    init(productServiceProvider: ProductServiceRepository.Type, categoryServiceProvider: CategoryServiceRepository.Type) {
        self.productServiceProvider = productServiceProvider
        self.categoryServiceProvider = categoryServiceProvider
    }
    
    // MARK: - Internal functions
    func searchProduct(query: String) {
        productServiceProvider.searchItem(query: query) { [weak self] response in
            switch response {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.delegate?.show(items: products)
                }
            case .failure(let error):
                self?.delegate?.handleError(error: error.errorDescription)
            }
        }
    }
    
    func loadCategories() {
        categoryServiceProvider.categoriesSearch { [weak self] response in
            switch response {
            case .success(let categories):
                self?.delegate?.reloadTable(categories: categories)
            case .failure(let error):
                self?.delegate?.handleError(error: error.errorDescription)
            }
        }
    }
    
    func searchProduct(by category: Category) {
        productServiceProvider.searchProducts(by: category.id) { [weak self] response in
            switch response {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.delegate?.show(items: products)
                }
            case .failure(let error):
                self?.delegate?.handleError(error: error.errorDescription)
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchProductPresenter: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            return
        }
        searchProduct(query: query)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.filterCategories(query: searchText)
    }
}
