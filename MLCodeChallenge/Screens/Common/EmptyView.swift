//
//  EmptyView.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    // MARK: - Constants
    private enum Constants {
        static let backgroundColor: UIColor? = .background
        
        enum ErrorLabel {
            static let font = UIFont.systemFont(ofSize: 30, weight: .bold)
            static let numberOfLines = 0
            static let textAlignment: NSTextAlignment = .center
            static let text = "emptyview.errorlabel.text".localized
            static let padding: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: -10)
            static let textColor: UIColor? = .mainContent
        }
    }
    
    // MARK: - Variables
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.ErrorLabel.font
        label.text = Constants.ErrorLabel.text
        label.textColor = Constants.ErrorLabel.textColor
        label.numberOfLines = Constants.ErrorLabel.numberOfLines
        label.textAlignment = Constants.ErrorLabel.textAlignment
        return label
    }()
    
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
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Constants.backgroundColor
        addSubview(errorLabel)
        
        let constraints = [errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                           errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.ErrorLabel.padding.left),
                           errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.ErrorLabel.padding.right)]
        
        NSLayoutConstraint.activate(constraints)
    }

}
