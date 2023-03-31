//
//  LunchCollectionViewCell.swift
//  practice
//
//  Created by aycan duskun on 31.03.2023.
//

import UIKit

class LunchCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "LunchCell"
    let lunchImageView = SPImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        //contentView.backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(category: Recipes) {
        lunchImageView.downloadImage(fromURL: category.image)
    }
    
    
    private func configure() {
        addSubviews(lunchImageView)
            
        NSLayoutConstraint.activate([
           lunchImageView.topAnchor.constraint(equalTo: topAnchor),
           lunchImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
           lunchImageView.heightAnchor.constraint(equalTo: heightAnchor),
           lunchImageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
