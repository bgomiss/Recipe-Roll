//
//  HeaderView.swift
//  practice
//
//  Created by aycan duskun on 28.03.2023.
//

import UIKit

class SPHeaderView: UICollectionReusableView {
    
    static let headerIdentifier         = "Header"
    let categoriesHeaderTitle           = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let categoriesSeeAllButton          = SPButton(backgroundColor: .clear, title: "See All")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        categoriesHeaderTitle.text = "Categories"
        backgroundColor = .systemBackground
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
    
    private func configureLayout() {
        let stackView = UIStackView(arrangedSubviews: [categoriesHeaderTitle, categoriesSeeAllButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            
            categoriesHeaderTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            categoriesHeaderTitle.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            ])
//        categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//        categoryView.topAnchor.constraint(equalTo: queryTextField.bottomAnchor, constant: 10),
//        categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//        categoryView.heightAnchor.constraint(equalToConstant: 30)
    }

}
