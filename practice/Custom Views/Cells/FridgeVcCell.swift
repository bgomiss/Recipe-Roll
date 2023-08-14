//
//  FridgeVcCell.swift
//  practice
//
//  Created by aycan duskun on 15.07.2023.
//

import UIKit

class FridgeVcCell: UICollectionViewCell {
    
    static let reuseID = "FridgeVcCell"
    let ingredientView = SPImageView(frame: .zero)
    let ingredientName = SPTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setFor(ingredients: Ingredient) {
    
        ingredientView.downloadImage(fromURL: ingredients.imageURL ?? "")
        ingredientName.text = ingredients.name.uppercased()
        
       }
    
    
    func setFor(recipes: FindByIngredients) {
    
        ingredientView.downloadImage(fromURL: recipes.image)
        ingredientName.text = recipes.title.uppercased()
        
       }
    
    
    private func configure() {
        addSubviews(ingredientView, ingredientName)
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            ingredientView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            ingredientView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            ingredientView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            ingredientView.heightAnchor.constraint(equalTo: ingredientView.widthAnchor),
            
            
            ingredientName.topAnchor.constraint(equalTo: ingredientView.bottomAnchor, constant: 12),
            ingredientName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            ingredientName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            ingredientName.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
