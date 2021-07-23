//
//  ProductListWorker.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

final class ProductListWorker: NSObject {
    
    private let items: Items
    
    init(items: Items) {
        self.items = items
    }
}

extension ProductListWorker: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let product = items.results[indexPath.row]
        cell.textLabel?.text = product.title
        return cell
    }
}
