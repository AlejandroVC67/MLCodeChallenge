//
//  MLSearchBar.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

final class MLSearchBar: UISearchBar {
    // MARK: - Constants
    private enum Constants {
        static let backgroundColor: UIColor? = .background
        
    }
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func setupView() {
        barTintColor = Constants.backgroundColor
        backgroundImage = UIImage()
    }
}
