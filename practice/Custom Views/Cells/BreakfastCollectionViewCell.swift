//
//  BreakfastCollectionViewCell.swift
//  practice
//
//  Created by aycan duskun on 31.03.2023.
//

import UIKit

class BreakfastCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "BreakfastCell"
    let breakfastImageView = SPImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        //contentView.backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(category: Recipes) {
        breakfastImageView.downloadImage(fromURL: category.image)
    }
    
    
    private func configure() {
        addSubviews(breakfastImageView)
            
        NSLayoutConstraint.activate([
           breakfastImageView.topAnchor.constraint(equalTo: topAnchor),
           breakfastImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
           breakfastImageView.heightAnchor.constraint(equalTo: heightAnchor),
           breakfastImageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
