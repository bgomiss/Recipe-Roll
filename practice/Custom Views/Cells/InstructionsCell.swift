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
    
    
    func setFeaturesCell(recipe: Recipe? = nil, recommendedRecipe: Instructions? = nil, categoryTitle: String? = nil) {
        addSubviews(cellTitle, clockImageView, readyInMinutes, peopleImageView, servings, likesImageView, aggregateLikes)
        
        if let recipe = recipe {
            cellTitle.text = recipe.title
            readyInMinutes.text = "\(String(recipe.readyInMinutes)) mins"
            servings.text = "\(String(recipe.servings)) people"
            aggregateLikes.text = "\(String(recipe.servings)) likes"
        } else if let recommendedRecipe = recommendedRecipe {
            cellTitle.text = recommendedRecipe.title
            readyInMinutes.text = "\(String(recommendedRecipe.readyInMinutes)) mins"
            servings.text = "\(String(recommendedRecipe.servings)) people"
            aggregateLikes.text = "\(String(recommendedRecipe.servings)) likes"
        }
        
        
        
        
        
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
    
    
    func setDescriptionCell(recipe: Recipe? = nil, recommendedRecipe: Instructions? = nil, categoryTitle: String? = nil) {
        addSubviews(descriptionLabel, summary)
        descriptionLabel.text = "Description"
        
        if let recipe = recipe {
            let attributedText = SPBodyLabel.convertHTMLToAttributedString(html: recipe.summary)
                summary.attributedText = attributedText
            } else if let recommmendedRecipe = recommendedRecipe {
                if let attributedText = SPBodyLabel.convertHTMLToAttributedString(html: recommmendedRecipe.summary) {
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
            
            
            func setInstructionsCell(recipe: Recipe, categoryTitle: String? = nil) {
                cellTitle.text = recipe.title
                
            }
        }
    }
