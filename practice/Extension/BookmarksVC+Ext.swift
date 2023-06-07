//
//  BookmarksVC+Ext.swift
//  practice
//
//  Created by aycan duskun on 30.03.2023.
//

import UIKit

extension BookmarksVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func getCategoryID(for section: Int) -> String {
            switch section {
            case 0:
                return "Recently Viewed"
            case 1:
                return "MadeIt"
            case 2:
                return "Breakfast"
            case 3:
                return "Lunch"
            case 4:
                return "Dinner"
            default:
                fatalError("Invalid Section: \(section)")
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
            
        case 1:
            return 3
       
        default:
            return 3
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RVCollectionViewCell.reuseID, for: indexPath) as? RVCollectionViewCell else {fatalError("unable to dequeue")}
        
        let categoryID = getCategoryID(for: indexPath.section)
        
        guard let recipes = recipes[categoryID] else {
            // Handle the case where the category ID is not found in the dictionary
            print("Recipes not found for category: \(categoryID)")
            return cell }
            
        switch indexPath.section {
        case 0:
            
            
            if indexPath.item == 2 {
                cell.overlayView.isHidden = false
            } else {
                cell.overlayView.isHidden = true
            }
            
            let index = recipes.count - 3 + indexPath.row
            if index >= 0 && index < recipes.count {
                let category = recipes[index]
                cell.set(category: category)
            }
            
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MadeItCollectionViewCell.reuseID, for: indexPath) as? MadeItCollectionViewCell else {fatalError("unable to dequeue")}
            
            if indexPath.item == 2 {
                cell.overlayView?.isHidden = false
            } else {
                cell.overlayView?.isHidden = true
            }
            
            
            let index = recipes.count - 3 + indexPath.row
            if index >= 0 && index < recipes.count {
                let category = recipes[index]
                cell.set(category: category)
            }
            
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreakfastCollectionViewCell.reuseID, for: indexPath) as? BreakfastCollectionViewCell else {fatalError("unable to dequeue")}
            
            if indexPath.item == 2 {
                cell.overlayView?.isHidden = false
            } else {
                cell.overlayView?.isHidden = true
            }
            
            
            let index = recipes.count - 3 + indexPath.row
            if index >= 0 && index < recipes.count {
                let category = recipes[index]
                cell.set(category: category)
            }
            
            return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LunchCollectionViewCell.reuseID, for: indexPath) as? LunchCollectionViewCell else {fatalError("unable to dequeue")}
            
            if indexPath.item == 2 {
                cell.overlayView.isHidden = false
            } else {
                cell.overlayView.isHidden = true
            }
            
            
            let index = recipes.count - 3 + indexPath.row
            if index >= 0 && index < recipes.count {
                let category = recipes[index]
                cell.set(category: category)
            }
            
            return cell
            
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DinnerCollectionViewCell.reuseID, for: indexPath) as? DinnerCollectionViewCell else {fatalError("unable to dequeue")}
            
            if indexPath.item == 2 {
                cell.overlayView.isHidden = false
            } else {
                cell.overlayView.isHidden = true
            }
            
            
            let index = recipes.count - 3 + indexPath.row
            if index >= 0 && index < recipes.count {
                let category = recipes[index]
                cell.set(category: category)
            }
            
            return cell
       
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.reuseID, for: indexPath) as? RecommendationCollectionViewCell else {fatalError("unable to dequeue")}
            let index = recipes.count - 3 + indexPath.row
            if index >= 0 && index < recipes.count {
                let category = recipes[index]
                cell.set(category: category)
            }
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: "RVHeader", withReuseIdentifier: RVHeaderView.headerIdentifier, for: indexPath) as! RVHeaderView
            return header
            
        case 1:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: "MadeItHeader", withReuseIdentifier: MadeItHeaderView.headerIdentifier, for: indexPath) as! MadeItHeaderView
            return header
            
        case 2:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: "BreakfastHeader", withReuseIdentifier: BreakfastHeaderView.headerIdentifier, for: indexPath) as! BreakfastHeaderView
            return header
            
        case 3:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: "LunchHeader", withReuseIdentifier: LunchHeaderView.headerIdentifier, for: indexPath) as! LunchHeaderView
            return header
            
        case 4:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: "DinnerHeader", withReuseIdentifier: DinnerHeaderView.headerIdentifier, for: indexPath) as! DinnerHeaderView
            return header
            
        default:
            fatalError("Unexpected section \(indexPath.section)")
        }
    }
    
}
