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
    var overlayView: OverlayView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        //contentView.backgroundColor = .systemYellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        overlayView?.frame = bounds
    }
    
    
    func set(category: Recipes) {
        breakfastImageView.downloadImage(fromURL: category.image)
    }
    
    
    private func configure() {
        addSubviews(breakfastImageView)
        overlayView = OverlayView(frame: bounds)
        addSubview(overlayView!)
            
        NSLayoutConstraint.activate([
           breakfastImageView.topAnchor.constraint(equalTo: topAnchor),
           breakfastImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
           breakfastImageView.heightAnchor.constraint(equalTo: heightAnchor),
           breakfastImageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
