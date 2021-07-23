//
//  SearchProductViewController.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas 
//

import UIKit

final class SearchProductViewController: UIViewController {

    private enum Constants {
        static let backgroundColor: UIColor? = .background
        
        enum Navbar {
            static let title = "searchproductviewcontroller.navbar.title".localized
            static let barTintColor: UIColor? = .mainColor
            static let isTranslucent = false
            static let titleAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.black as Any]
        }
        
        enum SearchBar {
            static let placeholder = "searchbar.placeholder".localized
        }
        
        enum TableView {
            static let topPadding: CGFloat = 10
        }
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = Constants.backgroundColor
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = Constants.SearchBar.placeholder
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = Constants.backgroundColor
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = dataSource
        table.estimatedRowHeight = UITableView.automaticDimension
        table.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        return table
    }()
    
    private let presenter: SearchProductPresenter
    private let dataSource: SearchProductDataSource = SearchProductDataSource()
    
    init(presenter: SearchProductPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadCategories()
        setupView()
    }
    
    private func setupView() {
        setupNavbar()
        view.addSubviews([searchBar, tableView])
        addSearchBarConstraints()
        addTableViewConstraints()
    }
    
    private func setupNavbar() {
        title = Constants.Navbar.title
        navigationController?.navigationBar.barTintColor = Constants.Navbar.barTintColor
        navigationController?.navigationBar.isTranslucent = Constants.Navbar.isTranslucent
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = Constants.Navbar.titleAttributes
        view.backgroundColor = Constants.backgroundColor
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
