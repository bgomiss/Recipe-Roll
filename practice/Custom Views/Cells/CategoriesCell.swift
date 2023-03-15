//
//  CategoriesCell.swift
//  practice
//
//  Created by aycan duskun on 15.03.2023.
//

import UIKit

class CategoriesCell: UITableViewCell {

    static let reuseID = "CategoriesCell"
    let categoryImageView = SPCategoryImageView(frame: .zero)
    let categoryLabel = SPTitleLabel(textAlignment: .center, fontSize: 15)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func set(category: Recipes) {
        categoryImageView.downloadImage(fromURL: category.image)
        categoryLabel.text = category.title
    }
    
    
    private func configure() {
        addSubviews(categoryImageView, categoryLabel)
        
    }
}
