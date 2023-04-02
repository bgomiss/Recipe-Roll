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
        madeItImageView.downloadImage(fromURL: category.image)
    }
    
    
    private func configure() {
        addSubviews(madeItImageView)
        overlayView = OverlayView(frame: bounds)
        addSubview(overlayView!)
            
        NSLayoutConstraint.activate([
           madeItImageView.topAnchor.constraint(equalTo: topAnchor),
           madeItImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
           madeItImageView.heightAnchor.constraint(equalTo: heightAnchor),
           madeItImageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
