//
//  InstructionsCell.swift
//  practice
//
//  Created by aycan duskun on 26.04.2023.
//

import UIKit

class InstructionsCell: UITableViewCell {
    
    static let reuseID = "InstructionsCell"
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
    
    
    func setFeaturesCell(recipe: Recipe, categoryTitle: String? = nil) {
        addSubviews(cellTitle, clockImageView, readyInMinutes, peopleImageView, servings, likesImageView, aggregateLikes)
        
        cellTitle.text = recipe.title
        readyInMinutes.text = "\(String(recipe.readyInMinutes)) mins"
        servings.text = "\(String(recipe.servings)) people"
        aggregateLikes.text = "\(String(recipe.servings)) likes"
        
        clockImageView.translatesAutoresizingMaskIntoConstraints = false
        clockImageView.image = RIMimage
        clockImageView.tintColor = .label
        clockImageView.contentMode = .scaleAspectFill
        
       peopleImageView.translatesAutoresizingMaskIntoConstraints = false
       peopleImageView.image = servingsImage
       peopleImageView.tintColor = .label
       peopleImageView.contentMode = .scaleAspectFill
        
       likesImageView.translatesAutoresizingMaskIntoConstraints = false
       likesImageView.image = ALimage
       likesImageView.tintColor = .label
       likesImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            cellTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cellTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellTitle.topAnchor.constraint(equalTo: topAnchor),
            cellTitle.heightAnchor.constraint(equalToConstant: 25),
            
            clockImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            clockImageView.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 20),
            clockImageView.heightAnchor.constraint(equalToConstant: 30),
            
            readyInMinutes.leadingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: 15),
            readyInMinutes.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 20),
            
            peopleImageView.leadingAnchor.constraint(equalTo: readyInMinutes.trailingAnchor, constant: 25),
            peopleImageView.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 20),
            peopleImageView.heightAnchor.constraint(equalToConstant: 30),
            
            servings.leadingAnchor.constraint(equalTo: peopleImageView.trailingAnchor, constant: 15),
            servings.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 20),
            servings.heightAnchor.constraint(equalToConstant: 30),
            
            likesImageView.leadingAnchor.constraint(equalTo: servings.trailingAnchor, constant: 25),
            likesImageView.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 20),
            likesImageView.heightAnchor.constraint(equalToConstant: 30),
            
            aggregateLikes.leadingAnchor.constraint(equalTo: likesImageView.trailingAnchor, constant: 15),
            aggregateLikes.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 20),
            aggregateLikes.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    
    func setDescriptionCell(recipe: Recipe, categoryTitle: String? = nil) {
        addSubviews(descriptionLabel, summary)
        descriptionLabel.text = "Description"
        if let attributedText = SPBodyLabel.convertHTMLToAttributedString(html: recipe.summary) {
            summary.attributedText = attributedText
        }
        
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 25),
            
            summary.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            summary.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            summary.bottomAnchor.constraint(equalTo: bottomAnchor),
            summary.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            //summary.heightAnchor.constraint(equalToConstant: 80)
            ])
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
    
    
    func setInstructionsCell(recipe: Recipe, categoryTitle: String? = nil) {
        cellTitle.text = recipe.title
        
    }
}
