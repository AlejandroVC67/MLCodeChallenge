//
//  CategoryTableViewCell.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    private enum Constants {
        enum TitleLabel {
            static let textColor: UIColor? = .mainContent
        }
        
        enum CategoryLabel {
            static let textColor: UIColor? = .secundaryContent
        }
    }
    
    private lazy var thumbnailImageView: UIImageView = {
        let thumbnail = UIImageView()
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        thumbnail.clipsToBounds = true
        return thumbnail
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.TitleLabel.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.CategoryLabel.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configureCell(title: String, imagePath: String) {
        
    }
}
