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
            static let placeholder = "searchproductviewcontroller.searchbar.placeholder".localized
        }
        
        enum TableView {
            static let topPadding: CGFloat = 10
        }
    }
    
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
        table.dataSource = tableWorker
        table.delegate = tableWorker
        table.estimatedRowHeight = UITableView.automaticDimension
        table.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        return table
    }()
    
    private var errorView: EmptyView?

    private let presenter: SearchProductPresenter
    private let tableWorker: SearchProductDataWorker = SearchProductDataWorker()
    private let logger: MLAnalyticsProtocol.Type
    
    init(presenter: SearchProductPresenter, analyticsLogger: MLAnalyticsProtocol.Type) {
        self.presenter = presenter
        self.logger = analyticsLogger
        super.init(nibName: nil, bundle: nil)
        self.presenter.delegate = self
        self.tableWorker.delegate = self
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
    func filterCategories(query: String) {
        tableWorker.filterCategories(basedOn: query)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func show(items: Items) {
        let presenter = ProductListPresenter()
        let logger = MLAnalyticsFactory.getLogger(provider: .native)
        let worker = ProductListWorker(items: items)
        let productListViewController = ProductListViewController(presenter: presenter, listWorker: worker, logger: logger)
        self.navigationController?.pushViewController(productListViewController, animated: true)
    }
    
    func reloadTable(categories: [Category]) {
        tableWorker.update(categories: categories)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func handleError(error: String) {
        logger.log(message: error, type: .error)
    }
}

extension SearchProductViewController: SearchProductDataWorkerDelegate {
    func checkProducts(of category: Category) {
        presenter.searchProduct(by: category)
    }
    
    func removeEmptyView() {
        if errorView != nil {
            errorView?.removeFromSuperview()
            errorView = nil
        }
    }
    
    func showEmptyView() {
        guard errorView == nil else {
            return
        }
        errorView = EmptyView()
        guard let errorView = errorView else {
            return
        }
        self.view.addSubview(errorView)
        
        let constraints = [errorView.topAnchor.constraint(equalTo: tableView.topAnchor),
                           errorView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
                           errorView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
                           errorView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
