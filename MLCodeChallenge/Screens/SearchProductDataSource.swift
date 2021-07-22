//
//  SearchProductDataSource.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

final class SearchProductDataSource: NSObject {
    private enum Constants {
        static let sectionTitle = "searchproductviewcontroller.table.section.title".localized
    }
    
    private var categories: [Category] = []
    
    func update(categories: [Category]) {
        self.categories = categories
    }
}

extension SearchProductDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
}