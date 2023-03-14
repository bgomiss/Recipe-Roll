//
//  Result.swift
//  practice
//
//  Created by aycan duskun on 14.03.2023.
//

import Foundation

struct Recipe: Codable {
    let results: [Recipes]
    let offset, number, totalResults: Int
}

// MARK: - Result
struct Recipes: Codable {
    let id: Int
    let title: String
    let image: String
}
