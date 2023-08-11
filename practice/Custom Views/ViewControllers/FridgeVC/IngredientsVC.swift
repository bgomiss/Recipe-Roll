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
    var fridgeVC: FridgeVC?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        setupStackView()
    }
    
    
    func addIngredient(_ ingredient: Ingredient) {
        let ingredientThumbs = SPImageView(frame: .zero)
        ingredientThumbs.downloadImage(fromURL: ingredient.imageURL ?? "")
        ingredientThumbs.contentMode = .scaleToFill
        ingredientThumbs.clipsToBounds = true
        ingredientThumbs.layer.cornerRadius = 15
        
        if stackView.arrangedSubviews.count < 4 {
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
        
        let count = fridgeVC!.getSelectedIngredientsCount() - 3
            print("TOTAL INGREDIENTS ARE: \(count)")
            countLabel.text = "+\(count)"
            countLabel.layoutIfNeeded()
            
            
            
            //Adjust the width constraint of ingredientThumbs view
            if let lastIngredientThumb = stackView.arrangedSubviews[stackView.arrangedSubviews.count - 4] as? SPImageView {
                let thumbWidth: CGFloat = (count < 3) ? (120 - CGFloat(count) * 40) : 20
                lastIngredientThumb.widthAnchor.constraint(equalToConstant: thumbWidth).isActive = true
            }
        }
    

    func setupStackView() {
        stackView.axis = .horizontal
        stackView.spacing = -10
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) 
        stackView.addArrangedSubview(ingredientThumbs)
    }
    
}
