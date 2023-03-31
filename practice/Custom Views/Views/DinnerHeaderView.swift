//
//  DinnerHeaderView.swift
//  practice
//
//  Created by aycan duskun on 31.03.2023.
//

import UIKit

class DinnerHeaderView: UICollectionReusableView {
        
    static let headerIdentifier         = "DinnerHeader"
    let dinnerHeaderTitle                   = SPTitleLabel(text: "Dinner", textAlignment: .left, fontSize: 20)
    let dinnerSeeAllButton                  = SPButton(backgroundColor: .clear, title: "See All")

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
        let stackView = UIStackView(arrangedSubviews: [dinnerHeaderTitle, dinnerSeeAllButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            dinnerHeaderTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            dinnerHeaderTitle.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            ])
    }
}
