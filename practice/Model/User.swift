//
//  User.swift
//  practice
//
//  Created by aycan duskun on 16.05.2023.
//

import Foundation

struct User: Codable {
    let uid: String?
    let name: String?
    var profileImageUrl: String?
    var bookmarkedRecipes: [String]?  // This could be an array of recipe IDs.
}

