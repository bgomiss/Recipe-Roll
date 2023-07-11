//
//  IngredientsVC.swift
//  practice
//
//  Created by aycan duskun on 11.07.2023.
//

import UIKit

class IngredientsVC: UIViewController {
    
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupConstraints()
    }
    

    func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 13
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
