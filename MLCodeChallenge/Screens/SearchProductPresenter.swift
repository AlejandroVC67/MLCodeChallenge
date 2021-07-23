//
//  SearchProductPresenter.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit
import OSLog

protocol SearchProductDelegate: AnyObject {
    func show(items: Items)
    func reloadTable(categories: [Category])
    func handleError(error: String)
    func filterCategories(query: String)
}

final class SearchProductPresenter: NSObject {
    
    weak var delegate: SearchProductDelegate?
    
    func searchProduct(query: String) {
        ServiceFacade.searchItem(query: query) { [weak self] response in
            switch response {
            case .success(let products):
                self?.delegate?.show(items: products)
            case .failure(let error):
                self?.delegate?.handleError(error: error.errorDescription)
            }
        }
    }
    
    func loadCategories() {
        ServiceFacade.categoriesSearch { [weak self] response in
            switch response {
            case .success(let categories):
                self?.delegate?.reloadTable(categories: categories)
            case .failure(let error):
                self?.delegate?.handleError(error: error.errorDescription)
            }
        }
    }
}

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

extension SearchProductPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}
