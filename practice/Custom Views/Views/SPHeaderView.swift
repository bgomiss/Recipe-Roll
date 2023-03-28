//
//  HeaderView.swift
//  practice
//
//  Created by aycan duskun on 28.03.2023.
//

import UIKit

class SPHeaderView: UIView {
    
    let categoriesHeaderTitle          = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let categoriesSeeAllButton         = SPButton(backgroundColor: .clear, title: "See All")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        categoriesHeaderTitle.text = "Categories"
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        addSubviews(categoriesHeaderTitle, categoriesSeeAllButton)
        
        NSLayoutConstraint.activate([
        categoriesHeaderTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        categoriesHeaderTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        categoriesHeaderTitle.heightAnchor.constraint(equalToConstant: 20),
        categoriesHeaderTitle.widthAnchor.constraint(equalToConstant: 50),
        
        categoriesSeeAllButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        categoriesSeeAllButton.heightAnchor.constraint(equalToConstant: 20),
        categoriesSeeAllButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        categoriesSeeAllButton.widthAnchor.constraint(equalToConstant: 50)
        ])
//        categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//        categoryView.topAnchor.constraint(equalTo: queryTextField.bottomAnchor, constant: 10),
//        categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//        categoryView.heightAnchor.constraint(equalToConstant: 30)
    }

}
