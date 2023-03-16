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
    let categoryLabel = SPTitleLabel(textAlignment: .center, fontSize: 15)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
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
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            categoryImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            categoryImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            categoryImageView.heightAnchor.constraint(equalToConstant: 60),
            categoryImageView.widthAnchor.constraint(equalToConstant: 60),
            
            categoryLabel.centerXAnchor.constraint(equalTo: categoryImageView.centerXAnchor),
            categoryLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 10),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
