//
//  User.swift
//  practice
//
//  Created by aycan duskun on 16.05.2023.
//

import Foundation

struct User {
    let uid: String
    let name: String
    let profileImageUrl: String
    var bookmarkedRecipes: [String]  // This could be an array of recipe IDs.
}

