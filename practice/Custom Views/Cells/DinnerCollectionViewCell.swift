//
//  DinnerCollectionViewCell.swift
//  practice
//
//  Created by aycan duskun on 31.03.2023.
//

import UIKit

class DinnerCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "DinnerCell"
    let dinnerImageView = SPImageView(frame: .zero)
    var overlayView = OverlayView(frame: .zero)
    
    
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
        overlayView.frame = bounds
    }
    
    
    func set(category: Recipe) {
        dinnerImageView.downloadImage(fromURL: category.image)
    }
    
    
    private func configure() {
        addSubviews(dinnerImageView)
        addSubview(overlayView)
            
        NSLayoutConstraint.activate([
           dinnerImageView.topAnchor.constraint(equalTo: topAnchor),
           dinnerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
           dinnerImageView.heightAnchor.constraint(equalTo: heightAnchor),
           dinnerImageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
