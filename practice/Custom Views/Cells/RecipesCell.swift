//
//  RecipesCell.swift
//  practice
//
//  Created by aycan duskun on 25.04.2023.
//

import UIKit

class RecipesCell: UITableViewCell {

    static let reuseID = "RecipesCell"
    let title          = SPTitleLabel(textAlignment: .center, fontSize: 20)
    let readyInMinutes = SPSecondaryTitleLabel(fontSize: 15)
    let servings       = SPSecondaryTitleLabel(fontSize: 15)
    let recipeImage    = SPImageView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(recipe: Recipe) {
        recipeImage.downloadImage(fromURL: recipe.image)
        title.text = recipe.title
        readyInMinutes.text = String(recipe.readyInMinutes)
        servings.text = String(recipe.servings)
    }
}
