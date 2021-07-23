//
//  SearchProductDataSource.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

final class SearchProductDataWorker: NSObject {
    private enum Constants {
        static let sectionTitle = "searchproductviewcontroller.table.section.title".localized
    }
    
    private var categories: [Category] = []
    private var storedCategories: [Category] = []
    
    func update(categories: [Category]) {
        self.categories = categories
        self.storedCategories = categories
    }
    
    func filterCategories(basedOn query: String) {
        if query.isEmpty {
            categories = storedCategories
            return
        }
        categories = storedCategories.filter { $0.name.contains(query) }
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
