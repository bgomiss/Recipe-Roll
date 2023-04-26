//
//  RecipesCell.swift
//  practice
//
//  Created by aycan duskun on 25.04.2023.
//

import UIKit

class RecipesCell: UITableViewCell {

    static let reuseID = "RecipesCell"
    let recipeTitle    = SPTitleLabel(textAlignment: .center, fontSize: 20)
    let readyInMinutes = SPSecondaryTitleLabel(fontSize: 15, color: .secondaryLabel)
    let servings       = SPSecondaryTitleLabel(fontSize: 15, color: .secondaryLabel)
    let recipeImage    = SPImageView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(recipe: Recipe, categoryTitle: String? = nil) {
        recipeImage.downloadImage(fromURL: recipe.image)
        recipeTitle.text = recipe.title
        readyInMinutes.text = "Ready In Minutes\n\(String(recipe.readyInMinutes))"
        servings.text = "Servings\n\(String(recipe.servings))"
    }
    
    private func configure() {
        addSubviews(recipeTitle, readyInMinutes, servings, recipeImage)
        
        NSLayoutConstraint.activate([
            recipeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            recipeImage.heightAnchor.constraint(equalToConstant: 80),
            recipeImage.widthAnchor.constraint(equalToConstant: 90),
            
            recipeTitle.leadingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: 20),
            recipeTitle.topAnchor.constraint(equalTo: recipeImage.topAnchor),
            recipeTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeTitle.heightAnchor.constraint(equalToConstant: 30),
            
            readyInMinutes.leadingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: 45),
            readyInMinutes.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 5),
            readyInMinutes.heightAnchor.constraint(equalToConstant: 40),
            
            servings.leadingAnchor.constraint(equalTo: readyInMinutes.trailingAnchor, constant: 45),
            servings.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 5),
            servings.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
