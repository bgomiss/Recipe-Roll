//
//  CustomCell.swift
//  practice
//
//  Created by aycan duskun on 3.05.2023.
//

import UIKit

class CustomCell: UITableViewCell {

    static let reuseID = "CustomCell"
    let cellTitle      = SPTitleLabel(textAlignment: .center, fontSize: 20)
    let readyInMinutes = SPSecondaryTitleLabel(fontSize: 15, color: .secondaryLabel)
    let RIMimage       = SFSymbols.clock
    let clockImageView = UIImageView()
    let peopleImageView = UIImageView()
    let likesImageView = UIImageView()
    let servings       = SPSecondaryTitleLabel(fontSize: 15, color: .secondaryLabel)
    let servingsImage  = SFSymbols.servings
    let aggregateLikes = SPSecondaryTitleLabel(fontSize: 15, color: .secondaryLabel)
    let ALimage        = SFSymbols.aggregateLikes
    
    
    let descriptionLabel = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let summary          = SPBodyLabel(textAlignment: .left)
    
    
    let ingredientsLabel = SPTitleLabel(textAlignment: .left, fontSize: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIngredientsCell(ingredients: [Ent], categoryTitle: String? = nil) {
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
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            ingredientsLabel.heightAnchor.constraint(equalToConstant: 25),
            ingredientsLabel.topAnchor.constraint(equalTo: topAnchor),
            
            stackView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        
        for ingredient in ingredients {
            let ingredientsImg = SPImageView(frame: .zero)
            let ingredientsAndEquipments = SPSecondaryTitleLabel(fontSize: 15, color: .black)
            ingredientsImg.downloadImage(fromURL: ingredient.image)
            ingredientsAndEquipments.text = ingredient.name
            
            let ingredientStackView = UIStackView(arrangedSubviews: [ingredientsImg, ingredientsAndEquipments])
            ingredientStackView.axis = .horizontal
            ingredientStackView.spacing = 10
            ingredientStackView.alignment = .leading
            ingredientStackView.distribution = .equalSpacing
            
            
            stackView.addArrangedSubview(ingredientStackView)
        }
    }
}
