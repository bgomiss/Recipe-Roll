//
//  RecommendationHeaderView.swift
//  practice
//
//  Created by aycan duskun on 29.03.2023.
//

import UIKit

class RecommendationHeaderView: UICollectionReusableView {
        
    static let headerIdentifier         = "RecommendationHeader"
    let recommendationHeaderTitle           = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let recommendationSeeAllButton          = SPButton(backgroundColor: .clear, title: "See All")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        recommendationHeaderTitle.text = "Recommendation"
        backgroundColor = .systemBackground
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
    
    private func configureLayout() {
        let stackView = UIStackView(arrangedSubviews: [recommendationHeaderTitle, recommendationSeeAllButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            recommendationHeaderTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            recommendationHeaderTitle.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            ])
    }

}
