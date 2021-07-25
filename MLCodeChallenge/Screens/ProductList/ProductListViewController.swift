//
//  ProductListViewController.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit
import SwiftUI

final class ProductListViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let backgroundColor: UIColor? = .background
        
        enum SearchBar {
            static let placeholder = "productlistviewcontroller.searchbar.placeholder".localized
        }
        
        enum TableView {
            static let topPadding: CGFloat = 10
        }
    }
    
    // MARK: - Variables
    private lazy var searchBar: MLSearchBar = {
        let searchBar = MLSearchBar()
        searchBar.delegate = presenter
        searchBar.placeholder = Constants.SearchBar.placeholder
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = Constants.backgroundColor
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = listWorker
        table.delegate = listWorker
        table.estimatedRowHeight = UITableView.automaticDimension
        table.register(ProductListTableViewCell.self, forCellReuseIdentifier: ProductListTableViewCell.reuseIdentifier)
        return table
    }()
    
    private let listWorker: ProductListWorker
    private let presenter: ProductListPresenter
    private let logger: MLAnalyticsProtocol.Type
    
    // MARK: - Init
    init(presenter: ProductListPresenter, listWorker: ProductListWorker, logger: MLAnalyticsProtocol.Type) {
        self.listWorker = listWorker
        self.logger = logger
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.delegate = self
        self.listWorker.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private functions
    private func setupView() {
        view.addSubviews([searchBar, tableView])
        view.backgroundColor = Constants.backgroundColor
        
        addSearchBarConstraints()
        addTableViewConstraints()
    }
    
    private func addSearchBarConstraints() {
        let constraints = [searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                           searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                           searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addTableViewConstraints() {
        let constraints = [tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: Constants.TableView.topPadding),
                           tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                           tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                           tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: - ProductListDelegate
extension ProductListViewController: ProductListDelegate {
    func filterProduct(by query: String) {
        listWorker.filterProducts(by: query)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - ProductListWorkerDelegate
extension ProductListViewController: ProductListWorkerDelegate {
    func checkDetail(of productId: String) {
        
        let vc = UIHostingController(rootView: ProductDetailViewController())
        navigationController?.pushViewController(vc, animated: true)
    }
}
