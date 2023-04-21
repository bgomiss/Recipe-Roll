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
            return recipes.count
            
        case 1:
            return 5
       
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reuseID, for: indexPath) as? CategoriesCollectionViewCell else {fatalError("unable to dequeue")}
            
            if recipes.isEmpty == false {
                let categoryTuple = recipes[indexPath.row]
                cell.set(category: categoryTuple.recipes.first, categoryName: categoryTuple.tag)
            }
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.reuseID, for: indexPath) as? RecommendationCollectionViewCell else {fatalError("unable to dequeue")}

//            if recipes.isEmpty == false {
//                let categoryTuple = recipes[indexPath.row]
//                cell.set(category: categoryTuple.recipes.first!)
            
            
            return cell
       
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.reuseID, for: indexPath) as? RecommendationCollectionViewCell else {fatalError("unable to dequeue")}
            
            if recipes.isEmpty == false {
                let categoryTuple = recipes[indexPath.row]
                cell.set(category: categoryTuple.recipes.first!)
            }
            
            return cell
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
