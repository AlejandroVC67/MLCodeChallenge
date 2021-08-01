//
//  ProductListTableViewCell.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

final class ProductListTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    private enum Constants {
        static let background: UIColor? = .background
        
        enum ThumbnailImageView {
            static let image = UIImage(named: "categoryPlaceholder")
            static let dimensions: CGFloat = 100
            static let padding: UIEdgeInsets = .init(top: 10, left: 10, bottom: -10, right: 0)
        }
        
        enum NameLabel {
            static let padding: UIEdgeInsets = .init(top: 10, left: 10, bottom: 0, right: -10)
            static let textColor: UIColor? = .mainContent
            static let font = UIFont.systemFont(ofSize: 14, weight: .bold)
            static let numberOfLines = 0
        }
        
        enum ConditionLabel {
            static let padding: UIEdgeInsets = .init(top: 2, left: 10, bottom: 0, right: -10)
            static let textColor: UIColor? = .secundaryContent
            static let font = UIFont.systemFont(ofSize: 10)
        }
        
        enum QuantityLabel {
            static let padding: UIEdgeInsets = .init(top: 2, left: 10, bottom: 0, right: -10)
            static let textColor: UIColor? = .secundaryContent
            static let font = UIFont.systemFont(ofSize: 10)
        }
        
        enum PriceLabel {
            static let padding: UIEdgeInsets = .init(top: 2, left: 10, bottom: 0, right: -10)
            static let textColor: UIColor? = .mainContent
            static let font = UIFont.systemFont(ofSize: 12)
        }
    }
    
    // MARK: - Variables
    private lazy var thumbnailImageView: UIImageView = {
        let thumbnail = UIImageView(image: Constants.ThumbnailImageView.image)
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        thumbnail.clipsToBounds = true
        thumbnail.contentMode = .scaleAspectFill
        return thumbnail
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.NameLabel.numberOfLines
        label.textColor = Constants.NameLabel.textColor
        label.font = Constants.NameLabel.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.PriceLabel.font
        label.textColor = Constants.PriceLabel.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.QuantityLabel.textColor
        label.font = Constants.QuantityLabel.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.ConditionLabel.font
        label.textColor = Constants.ConditionLabel.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Internal functions
    func configureCell(name: String, price: String, quantity: String, condition: String, thumbnailPath: String) {
        contentView.backgroundColor = Constants.background
        thumbnailImageView.downloadImage(from: thumbnailPath)
        nameLabel.text = name
        priceLabel.text = price
        quantityLabel.text = quantity
        conditionLabel.text = condition
        
        contentView.addSubviews([thumbnailImageView, nameLabel, conditionLabel, quantityLabel, priceLabel])
        
        addThumbnailImageViewConstraints()
        addNameLabelConstraints()
        addConditionLabelConstraints()
        addQuantityLabelConstraints()
        addPriceLabelConstraints()
    }
    
    // MARK: - Private functions
    private func addThumbnailImageViewConstraints() {
        let constraints = [thumbnailImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: Constants.ThumbnailImageView.padding.top),
                           thumbnailImageView.widthAnchor.constraint(equalToConstant: Constants.ThumbnailImageView.dimensions),
                           thumbnailImageView.heightAnchor.constraint(equalToConstant: Constants.ThumbnailImageView.dimensions),
                           thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.ThumbnailImageView.padding.left),
                           thumbnailImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: Constants.ThumbnailImageView.padding.bottom),
                           thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addNameLabelConstraints() {
        let constraints = [nameLabel.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor),
                           nameLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: Constants.NameLabel.padding.left),
                           nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.NameLabel.padding.right)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addConditionLabelConstraints() {
        let constraints = [conditionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.ConditionLabel.padding.top),
                           conditionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                           conditionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)]

        NSLayoutConstraint.activate(constraints)
    }

    private func addQuantityLabelConstraints() {
        let constraints = [quantityLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: Constants.QuantityLabel.padding.top),
                           quantityLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                           quantityLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)]

        NSLayoutConstraint.activate(constraints)
    }
    
    private func addPriceLabelConstraints() {
        let constraints = [priceLabel.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: Constants.PriceLabel.padding.top),
                           priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                           priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)]

        NSLayoutConstraint.activate(constraints)
    }
}
