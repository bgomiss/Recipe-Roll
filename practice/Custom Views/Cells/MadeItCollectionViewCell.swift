//
//  MadeItCollectionViewCell.swift
//  practice
//
//  Created by aycan duskun on 31.03.2023.
//

import UIKit

class MadeItCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "MadeItCell"
    let madeItImageView = SPImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        //contentView.backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(category: Recipes) {
        madeItImageView.downloadImage(fromURL: category.image)
    }
    
    
    private func configure() {
        addSubviews(madeItImageView)
            
        NSLayoutConstraint.activate([
           madeItImageView.topAnchor.constraint(equalTo: topAnchor),
           madeItImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
           madeItImageView.heightAnchor.constraint(equalTo: heightAnchor),
           madeItImageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
