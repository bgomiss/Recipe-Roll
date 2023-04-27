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
    let recipeImage    = SPImageView(frame: .zero)
    
    let descriptionLabel    = SPBodyLabel(textAlignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setFeaturesCell(recipe: Recipe, categoryTitle: String? = nil) {
        addSubviews(cellTitle, clockImageView, readyInMinutes, peopleImageView, servings, likesImageView, aggregateLikes)
        
        recipeImage.downloadImage(fromURL: recipe.image)
        cellTitle.text = recipe.title
        readyInMinutes.text = "\(String(recipe.readyInMinutes)) mins"
        servings.text = "\(String(recipe.servings)) people"
        aggregateLikes.text = "(String(recipe.servings)) likes"
        
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
            cellTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            cellTitle.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            cellTitle.heightAnchor.constraint(equalToConstant: 25),
            
            clockImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            clockImageView.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 20),
            clockImageView.heightAnchor.constraint(equalToConstant: 30),
            
            readyInMinutes.leadingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: 15),
            readyInMinutes.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 20),
            
            peopleImageView.leadingAnchor.constraint(equalTo: readyInMinutes.trailingAnchor, constant: 25),
            peopleImageView.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 20),
            peopleImageView.heightAnchor.constraint(equalToConstant: 30),
            
            servings.leadingAnchor.constraint(equalTo: peopleImageView.trailingAnchor, constant: 25),
            servings.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 20),
            servings.heightAnchor.constraint(equalToConstant: 30),
            
            likesImageView.leadingAnchor.constraint(equalTo: servings.trailingAnchor, constant: 25),
            likesImageView.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 20),
            likesImageView.heightAnchor.constraint(equalToConstant: 30),
            
            aggregateLikes.leadingAnchor.constraint(equalTo: likesImageView.trailingAnchor, constant: 25),
            aggregateLikes.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 20),
            aggregateLikes.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    
    func setDescriptionCell(recipe: Recipe, categoryTitle: String? = nil) {
        cellTitle.text = "Description"
        descriptionLabel.text = recipe.summary
    }
    
    
    func setIngredientsCell(recipe: Recipe, categoryTitle: String? = nil) {
        cellTitle.text = "Ingredients"
        
    }
    
    
    func setInstructionsCell(recipe: Recipe, categoryTitle: String? = nil) {
        cellTitle.text = recipe.title
        
    }
}
