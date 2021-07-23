//
//  MLSearchBar.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

final class MLSearchBar: UISearchBar {
    
    private enum Constants {
        static let backgroundColor: UIColor? = .background
        
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        barTintColor = Constants.backgroundColor
        backgroundImage = UIImage()
    }
}
