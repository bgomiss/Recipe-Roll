//
//  CategoriesCell.swift
//  practice
//
//  Created by aycan duskun on 15.03.2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    static let reuseID = "CategoriesCell"
    let categoryImageView = SPCategoryImageView(frame: .zero)
    let categoryLabel = SPTitleLabel(textAlignment: .center, fontSize: 10)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        //contentView.backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(category: Recipes) {
        categoryImageView.downloadImage(fromURL: category.image)
        categoryLabel.text = category.title
    }
    
    
    private func configure() {
        addSubviews(categoryImageView, categoryLabel)
            
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: self.topAnchor),
            categoryImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            categoryImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            categoryLabel.centerXAnchor.constraint(equalTo: categoryImageView.centerXAnchor),
            categoryLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}

