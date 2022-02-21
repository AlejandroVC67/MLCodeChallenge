//
//  SearchProductViewController.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas 
//

import UIKit

final class SearchProductViewController: UIViewController {

    // MARK: - Constants
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
    
    // MARK: - Init
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
    
    // MARK: - Private functions
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

// MARK: - SearchProductDelegate
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

// MARK: - SearchProductDataWorkerDelegate
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

extension CategoryServiceClient {
    static var badURL = Self(
        categoriesSearch: { $0(.failure(.badUrl)) },
        searchCategory: { _, _ in }
    )
    static func error(_ error: ServiceError) -> Self {
        Self(
            categoriesSearch: { $0(.failure(error)) },
            searchCategory: { _, _ in }
        )
    }
    static func success(_ categories: Category...) -> Self {
        Self(
            categoriesSearch: { $0(.success(categories)) },
            searchCategory: { _, _ in }
        )
    }
}

struct SearchViewController_Previews: PreviewProvider {
    static var previews: some View {
//        environment.categoriesSearchClient = .error(.emptyResponse)
        environment.categoriesSearchClient = .success(
            .init(id: "0", name: "Tractores", picture: "https://www.deere.com//assets/images/Tractor%206110e/tractor_6110E_campo4_large_81c750cb461dc7e9617daa06490faff0c2b72b9e.jpg"),
            .init(id: "1", name: "Nueva 2", picture: nil),
            .init(id: "2", name: "Nueva 3", picture: nil)
        )

        return UIViewControllerToSwiftUI { _ in
            SearchProductViewController.init(
                presenter: .init(productServiceProvider: ProductServiceFacade.self),
                analyticsLogger: MLAnalyticsFactory.getLogger(provider: .native)
            )
        }
    }
}

import SwiftUI
public struct UIViewControllerToSwiftUI: UIViewControllerRepresentable {

    public typealias UIViewControllerType = UIViewController

    let makeUIViewControllerHandler: (Context) -> UIViewControllerType
    let updateUIViewControllerHandler: ((UIViewController, Context) -> Void)?

    public init(
        makeUIViewControllerHandler: @escaping (Context) -> UIViewControllerType,
        updateUIViewControllerHandler: ((UIViewController, Context) -> Void)? = nil
    ) {
        self.makeUIViewControllerHandler = makeUIViewControllerHandler
        self.updateUIViewControllerHandler = updateUIViewControllerHandler
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        makeUIViewControllerHandler(context)
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        updateUIViewControllerHandler?(uiViewController, context)
    }
}
