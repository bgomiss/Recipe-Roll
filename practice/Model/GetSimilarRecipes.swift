//
//  GetSimilarRecipes.swift
//  practice
//
//  Created by aycan duskun on 20.08.2023.
//

import Foundation

 struct GetSimilarRecipes: Codable, Hashable {
    let id: Int
    let imageType: String
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String
     
    var imageURL: String? {
             return "https://spoonacular.com/recipeImages/\(id)-312x231.\(imageType)"
         }
}


