//
//  RVCollectionViewCell.swift
//  practice
//
//  Created by aycan duskun on 30.03.2023.
//

import UIKit

class RVCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "RVCell"
    let rvImageView = SPImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        //contentView.backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(category: Recipes) {
        rvImageView.downloadImage(fromURL: category.image)
    }
    
    
    private func configure() {
        addSubviews(rvImageView)
            
        NSLayoutConstraint.activate([
           rvImageView.topAnchor.constraint(equalTo: topAnchor),
           rvImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
           rvImageView.heightAnchor.constraint(equalTo: heightAnchor),
           rvImageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
