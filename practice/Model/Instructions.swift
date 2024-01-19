//
//  Instructions.swift
//  practice
//
//  Created by aycan duskun on 6.01.2024.
//

import Foundation

struct Instructions: Codable, Hashable, Equatable {
    
    let vegetarian: Bool = false
    let vegan: Bool = false
    let glutenFree: Bool = false
    let dairyFree: Bool = false
    let veryHealthy: Bool = false
    let cheap: Bool = false
    let veryPopular: Bool = false
    let sustainable: Bool = false
    let lowFodmap: Bool = false
    let weightWatcherSmartPoints: Int = 0
    let gaps: String = ""
    let preparationMinutes: Int = 0
    let cookingMinutes: Int = 0
    let aggregateLikes: Int
    let healthScore: Int = 0
    let creditsText: String = ""
    let license: String = ""
    let sourceName: String = ""
    let pricePerServing: Double = 0
    let extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String = ""
    let image: String
    let imageType: String
    let summary: String
    let cuisines: [String] = []
    let dishTypes: [String] = []
    let diets: [String] = []
    let occasions: [String] = []
    let winePairing: WinePairing?
    let instructions: String = ""
    let analyzedInstructions: [AnalyzedInstructions]
    let originalId: Int? = 0
    let spoonacularScore: Double = 0
    let spoonacularSourceUrl: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, imageType, winePairing, analyzedInstructions, extendedIngredients, summary, readyInMinutes, servings, aggregateLikes
    }
}

struct ExtendedIngredient: Codable, Hashable, Equatable {
    let id: Int
    let aisle: String
    let image: String
    let consistency: String
    let name: String
    let nameClean: String
    let original: String
    let originalName: String
    let amount: Double
    let unit: String
    let meta: [String]
    let measures: Measures
}

struct Measures: Codable, Hashable, Equatable {
    let us: Measure
    let metric: Measure
}

struct Measure: Codable, Hashable, Equatable {
    let amount: Double
    let unitShort: String
    let unitLong: String
}

struct WinePairing: Codable, Hashable, Equatable {
    let pairedWines: [String]
    let pairingText: String
    let productMatches: [ProductMatch]
}

struct ProductMatch: Codable, Hashable, Equatable {
}

struct AnalyzedInstructions: Codable, Hashable, Equatable {
    let name: String
    let steps: [Steps]
}

struct Steps: Codable, Hashable, Equatable {
    let number: Int
    let step: String
    let ingredients: [Ingredients]
    let equipment: [Equipments]
    let length: Lengths?
}

struct Ingredients: Codable, Hashable, Equatable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String
}

struct Equipments: Codable, Hashable, Equatable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String
}

struct Lengths: Codable, Hashable, Equatable {
    let number: Int
    let unit: String
}
