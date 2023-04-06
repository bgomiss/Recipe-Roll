//
//  RVHeaderView.swift
//  practice
//
//  Created by aycan duskun on 30.03.2023.
//

import UIKit

class RVHeaderView: UICollectionReusableView {
        
    static let headerIdentifier         = "RVHeader"
    let rvHeaderTitle                   = SPTitleLabel(text: "Recently Viewed", textAlignment: .left, fontSize: 20)
    let rvSeeAllButton                  = SPButton(backgroundColor: .clear, title: "See All")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor = .systemBackground
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
    
    private func configureLayout() {
        let stackView = UIStackView(arrangedSubviews: [rvHeaderTitle, rvSeeAllButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            rvHeaderTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            rvHeaderTitle.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            ])
    }

}
