//
//  CustomCell.swift
//  practice
//
//  Created by aycan duskun on 3.05.2023.
//

import UIKit

class IngredientsCell: UITableViewCell {

    static let reuseID = "IngredientsCell"
    let ingredientsLabel = SPTitleLabel(textAlignment: .left, fontSize: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIngredientsCell(ingredients: [Ent]? = [], recommendedRecipeIngredients: [Ingredients]? = [], categoryTitle: String? = nil) {
        let stackView = UIStackView()
        addSubviews(ingredientsLabel, stackView)
        ingredientsLabel.text = "Ingredients"
        
        stackView.axis = .vertical
        stackView.spacing = 13
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        NSLayoutConstraint.activate([
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            ingredientsLabel.heightAnchor.constraint(equalToConstant: 25),
            ingredientsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
        
            stackView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        if let ingredients = ingredients {
                for ingredient in ingredients {
        
            let ingredientsImg = SPImageView(frame: .zero)
            let ingredientsAndEquipments = SPSecondaryTitleLabel(fontSize: 15, color: .black, weight: .bold)
            ingredientsImg.downloadImage(fromURL: ingredient.image)
            ingredientsAndEquipments.text = ingredient.name.uppercased()
            ingredientsImg.heightAnchor.constraint(equalToConstant: 40).isActive = true
            ingredientsImg.widthAnchor.constraint(equalToConstant: 40).isActive = true
            
            
            let ingredientStackView = UIStackView(arrangedSubviews: [ingredientsImg, ingredientsAndEquipments])
            ingredientStackView.axis = .horizontal
            ingredientStackView.spacing = 10
            ingredientStackView.alignment = .center
            ingredientStackView.distribution = .fill
            ingredientStackView.layer.cornerRadius = 10
            ingredientStackView.backgroundColor = .systemMint.withAlphaComponent(0.5)
            
            stackView.addArrangedSubview(ingredientStackView)
            
            ingredientsAndEquipments.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        }
        } else if let recommendedRecipeIngredients = recommendedRecipeIngredients {
                for ingredient in recommendedRecipeIngredients {
            
                let ingredientsImg = SPImageView(frame: .zero)
                let ingredientsAndEquipments = SPSecondaryTitleLabel(fontSize: 15, color: .black, weight: .bold)
                ingredientsImg.downloadImage(fromURL: ingredient.image)
                ingredientsAndEquipments.text = ingredient.name.uppercased()
                ingredientsImg.heightAnchor.constraint(equalToConstant: 40).isActive = true
                ingredientsImg.widthAnchor.constraint(equalToConstant: 40).isActive = true
                
                
                let ingredientStackView = UIStackView(arrangedSubviews: [ingredientsImg, ingredientsAndEquipments])
                ingredientStackView.axis = .horizontal
                ingredientStackView.spacing = 10
                ingredientStackView.alignment = .center
                ingredientStackView.distribution = .fill
                ingredientStackView.layer.cornerRadius = 10
                ingredientStackView.backgroundColor = .systemMint.withAlphaComponent(0.5)
                
                stackView.addArrangedSubview(ingredientStackView)
                
                ingredientsAndEquipments.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
            }
        }
        }
}
