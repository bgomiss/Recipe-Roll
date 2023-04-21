//
//  Result.swift
//  practice
//
//  Created by aycan duskun on 14.03.2023.
//

import Foundation

// MARK: - Recipe
struct Recipe: Codable {
    let results: [Recipes]
}

// MARK: - RecipeElement
struct Recipes: Codable, Equatable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool
    let veryHealthy, cheap, veryPopular, sustainable: Bool
    let lowFodmap: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int
    let creditsText, sourceName: String
    let pricePerServing: Double
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let sourceUrl: String
    let image: String
    let imageType, summary: String
    let instructions: String
    let spoonacularSourceUrl: String

}
