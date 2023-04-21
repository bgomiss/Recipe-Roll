//
//  Result.swift
//  practice
//
//  Created by aycan duskun on 14.03.2023.
//

import Foundation

// MARK: - RecipeResults
struct RecipeResults: Codable {
    let results: [Recipe]
    let offset, number, totalResults: Int
}

// MARK: - Recipe
struct Recipe: Codable, Equatable, Hashable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}
//// MARK: - Recipe
//struct Recipe: Codable, Hashable {
//    let results: [Recipes]
//}
//
//// MARK: - RecipeElement
//struct Recipes: Codable, Equatable, Hashable {
//    let vegetarian, vegan, glutenFree, dairyFree: Bool
//    let veryHealthy, cheap, veryPopular, sustainable: Bool
//    let lowFodmap: Bool
//    let weightWatcherSmartPoints: Int
//    let gaps: String
//    let preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int
//    let creditsText, sourceName: String
//    let pricePerServing: Double
//    let id: Int
//    let title: String
//    let readyInMinutes, servings: Int
//    let sourceUrl: String
//    let image: String
//    let imageType, summary: String
//    let instructions: String
//    let spoonacularSourceUrl: String
//
//}
