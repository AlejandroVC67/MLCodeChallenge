//
//  CategoryTableViewCell.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    private enum Constants {
        static let background: UIColor? = .background
        
        enum ThumbnailImageView {
            static let image = UIImage(named: "categoryPlaceholder")
            static let width: CGFloat = 200
        }
        enum CategoryLabel {
            static let textColor: UIColor? = .secundaryContent
            static let font = UIFont.systemFont(ofSize: 20, weight: .bold)
            static let padding: UIEdgeInsets = .init(top: 8, left: 10, bottom: -10, right: -10)
            static let numberOfLines = 0
        }
    }
    
    // MARK: - Variables
    private lazy var thumbnailImageView: UIImageView = {
        let thumbnail = UIImageView(image: Constants.ThumbnailImageView.image)
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        thumbnail.clipsToBounds = true
        return thumbnail
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.CategoryLabel.font
        label.textColor = Constants.CategoryLabel.textColor
        label.numberOfLines = Constants.CategoryLabel.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Internal functions
    func configureCell(category: String, imagePath: String?) {
        contentView.backgroundColor = Constants.background
        categoryLabel.text = category
        thumbnailImageView.downloadImage(from: imagePath)
        
        contentView.addSubviews([thumbnailImageView, categoryLabel])
        thumbnailImageViewConstraints()
        categoryLabelConstraints()
    }
    
    // MARK: - Private functions
    private func thumbnailImageViewConstraints() {
        let constraints = [thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                           thumbnailImageView.widthAnchor.constraint(equalToConstant: Constants.ThumbnailImageView.width),
                           thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, multiplier: thumbnailImageView.aspectRatio),
                           thumbnailImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func categoryLabelConstraints() {
        let constraints = [categoryLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: Constants.CategoryLabel.padding.top),
                           categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.CategoryLabel.padding.left),
                           categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.CategoryLabel.padding.right),
                           categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.CategoryLabel.padding.bottom)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
