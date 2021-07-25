//
//  SearchProductDataSource.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

protocol SearchProductDataWorkerDelegate: AnyObject {
    func showEmptyView()
    func removeEmptyView()
    func checkProducts(of category: Category)
}

final class SearchProductDataWorker: NSObject {
    private enum Constants {
        static let sectionTitle = "searchproductviewcontroller.table.section.title".localized
    }
    
    private var categories: [Category] = []
    private var storedCategories: [Category] = []
    weak var delegate: SearchProductDataWorkerDelegate?
    
    func update(categories: [Category]) {
        self.categories = categories
        self.storedCategories = categories
    }
    
    func filterCategories(basedOn query: String) {
        if query.isEmpty {
            categories = storedCategories
            delegate?.removeEmptyView()
            return
        }
        categories = storedCategories.filter { $0.name.localizedCaseInsensitiveContains(query) }
        categories.isEmpty ? delegate?.showEmptyView() : delegate?.removeEmptyView()
    }
}

extension SearchProductDataWorker: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        let category = categories[indexPath.row]
        
        cell.configureCell(category: category.name, imagePath: category.picture)
        return cell
    }
}

extension SearchProductDataWorker: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        delegate?.checkProducts(of: category)
    }
}
