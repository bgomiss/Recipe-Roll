//
//  CategoriesCell.swift
//  practice
//
//  Created by aycan duskun on 15.03.2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    static let reuseID = "CategoriesCell"
    let categoryImageView = SPImageView(frame: .zero)
    let categoryLabel = SPTitleLabel(textAlignment: .center, fontSize: 10)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        //contentView.backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImageView.image = nil
        categoryLabel.text = ""
    }

    
    
    func set(category: Recipes? = nil, categoryName: String? = nil) {
        categoryImageView.downloadImage(fromURL: category?.image ?? "")
        categoryLabel.text = categoryName
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

