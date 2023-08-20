//
//  GetSimilarRecipes.swift
//  practice
//
//  Created by aycan duskun on 20.08.2023.
//

import Foundation

struct FindByIngredients: Codable, Hashable {
    let id: Int
    let imageType: String
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String
}
