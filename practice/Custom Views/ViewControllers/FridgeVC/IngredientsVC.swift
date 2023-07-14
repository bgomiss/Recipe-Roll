//
//  IngredientsVC.swift
//  practice
//
//  Created by aycan duskun on 11.07.2023.
//

import UIKit

class IngredientsVC: UIViewController {
    
    let stackView           = UIStackView()
    let ingredientThumbs    = SPImageView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        setupStackView()
    }
    
    
    func addIngredient(_ ingredient: String) {
        ingredientThumbs.image = UIImage(systemName: "bookmark")
        ingredientThumbs.contentMode = .scaleAspectFill
        ingredientThumbs.clipsToBounds = true
        
        if stackView.arrangedSubviews.count < 3 {
            stackView.addArrangedSubview(ingredientThumbs)
        } else {
            updateCountLabel()
        }
        stackView.layoutIfNeeded()
    }
    
    
    func updateCountLabel() {
        let countLabel: UILabel
        if let lastView = stackView.arrangedSubviews.last as? UILabel {
            countLabel = lastView
        } else {
            countLabel = UILabel()
            countLabel.backgroundColor = .white
            stackView.addArrangedSubview(countLabel)
        }
        let count = stackView.arrangedSubviews.count - 2
        countLabel.text = "+\(count)"
        countLabel.layoutIfNeeded()
    }
    

    func setupStackView() {
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) 
        stackView.addArrangedSubview(ingredientThumbs)
    }
    
}
