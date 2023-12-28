
//
//  File.swift
//  practice
//
//  Created by aycan duskun on 27.03.2023.
//

import UIKit

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            print("RECIPEScount is: \(recipes.count)")
            return recipes.count
        
            
        case 1:
            print("similarRECIPEScount is: \(similarRecipesArray.count)")
            return similarRecipesArray.count
            
        default:
            return recipes.count
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            
            let lunchIndex = tags.firstIndex(of: Tags.lunch) ?? -1
            let categoryTuple = recipes[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reuseID, for: indexPath) as? CategoriesCollectionViewCell else {fatalError("unable to dequeue")}
            
            if recipes.isEmpty == false {
                if indexPath.row == lunchIndex, categoryTuple.recipe.count > 1 {
                    cell.set(category: categoryTuple.recipe[2], categoryName: categoryTuple.tag)
                } else {
                    cell.set(category: categoryTuple.recipe.first, categoryName: categoryTuple.tag)
                }
            }
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.reuseID, for: indexPath) as? RecommendationCollectionViewCell else {fatalError("unable to dequeue")}
            
            let recipe = similarRecipesArray[indexPath.row]
            cell.set(category: recipe)
            
            
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reuseID, for: indexPath) as? CategoriesCollectionViewCell else {fatalError("unable to dequeue")}

            if recipes.isEmpty == false {
                let categoryTuple = recipes[indexPath.row]
                cell.set(category: categoryTuple.recipe.first!)
                
                }
            return cell
        }
}
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let selectedCategory = recipes[indexPath.row]
            let destVC = RecipeResultsVC(category: selectedCategory.tag)
            navigationController?.pushViewController(destVC, animated: true)
            
        default:
            break
        }
    }
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            switch indexPath.section {
            case 0:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: "CategoriesHeader", withReuseIdentifier: CategoriesHeaderView.headerIdentifier, for: indexPath) as! CategoriesHeaderView
                return header
                
            case 1:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: "RecommendationHeader", withReuseIdentifier: RecommendationHeaderView.headerIdentifier, for: indexPath) as! RecommendationHeaderView
                return header
                
            default:
                fatalError("Unexpected section \(indexPath.section)")
            }
        }
        
    }

