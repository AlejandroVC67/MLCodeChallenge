//
//  SearchProductViewController.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas 
//

import UIKit

final class SearchProductViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = dataSource
        return table
    }()
    
    private let presenter: SearchProductPresenter
    private let dataSource: SearchProductDataSource = SearchProductDataSource()
    
    init(presenter: SearchProductPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.delegate = self
        self.presenter.loadCategories()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        title = "Search Products"
        navigationController?.navigationBar.backgroundColor = .yellow
        view.backgroundColor = .white
        addTable()
    }
    
    private func addTable() {
        view.addSubview(tableView)
        
        let constraints = [tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                           tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                           tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                           tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension SearchProductViewController: SearchProductDelegate {
    func show(items: Items) {
        // TODO
    }
    
    func reloadTable(categories: [Category]) {
        dataSource.update(categories: categories)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func handleError(error: String) {
        // TODO
    }
}
