//
//  RecommendationCollectionViewCell.swift
//  practice
//
//  Created by aycan duskun on 27.03.2023.
//

import UIKit

class RecommendationCollectionViewCell: UICollectionViewCell {

        static let reuseID          = "RecommendationCell"
        let recommendationImageView = SPImageView(frame: .zero)
        let recommendationLabel     = SPTitleLabel(textAlignment: .center, fontSize: 15)
        
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
            //contentView.backgroundColor = .systemPink
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        func set(category: GetSimilarRecipes) {
            recommendationImageView.downloadImage(fromURL: category.imageURL ?? "")
            recommendationLabel.lineBreakMode = .byTruncatingTail
            recommendationLabel.text = category.title
        }
        
        
        private func configure() {
            addSubviews(recommendationImageView, recommendationLabel)
            
            NSLayoutConstraint.activate([
               
               recommendationImageView.topAnchor.constraint(equalTo: self.topAnchor),
               recommendationImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               recommendationImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
               recommendationImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
                
               recommendationLabel.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: 8),
               recommendationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
               recommendationLabel.topAnchor.constraint(equalTo: recommendationImageView.bottomAnchor),
               recommendationLabel.heightAnchor.constraint(equalToConstant: 35)
            ])
        }
    }
