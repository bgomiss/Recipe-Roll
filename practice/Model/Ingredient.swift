//
//  Ingredient.swift
//  practice
//
//  Created by aycan duskun on 23.07.2023.
//

import UIKit

struct Ingredient: Codable, Hashable {
    let name: String
    let image: String
    
    var imageURL: String? {
        return "https://spoonacular.com/cdn/ingredients_100x100/\(image)"
    }
}
