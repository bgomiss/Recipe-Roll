//
//  BookmarksVC+Ext.swift
//  practice
//
//  Created by aycan duskun on 30.03.2023.
//

import UIKit

extension BookmarksVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func getCategoryID(for section: Int) -> String? {
        return categoryMapping[section]
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let categoryID = getCategoryID(for: section),
              let index = bookmarkedRecipes.firstIndex(where: { $0.0 == categoryID }) else {
                return 0
    }
        let categoryRecipes = bookmarkedRecipes[index].1
        return min(3, categoryRecipes.count)
//        let itemsToDisplay = min(3, bookmarkedRecipes.count)
//        
//        switch section {
//        case 0:
//            return itemsToDisplay
//            
//        case 1:
//            return itemsToDisplay
//            
//        case 2:
//            return itemsToDisplay
//            
//        case 3:
//            return itemsToDisplay
//            
//        case 4:
//            return itemsToDisplay
//            
//        default:
//            return itemsToDisplay
//        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        categoryMapping.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let categoryID = getCategoryID(for: indexPath.section),
              let index = bookmarkedRecipes.firstIndex(where: { $0.0 == categoryID}),
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RVCollectionViewCell.reuseID, for: indexPath) as? RVCollectionViewCell else {fatalError("unable to dequeue")}
        
            print("CATEGORY: \(categoryID)")
            let categoryRecipes = self.bookmarkedRecipes[index].1
            let displayedRecipes = Array(categoryRecipes.prefix(3))
            print("ISTE BUNLAR: \(self.bookmarkedRecipes[index].0) \(displayedRecipes.count)")
        
            if indexPath.item == 2 {
                let count = max(0, categoryRecipes.count - 3)
                self.setOverlayView(for: cell, countedNumber: count)
            } else {
                cell.overlayView.isHidden = true
            }
            
            let category = displayedRecipes[indexPath.item]
            cell.set(category: category)
            return cell
        }
    
            // Access the tuple using the index
//            let tuple = bookmarkedRecipes[index]
//            let categoryRecipes = tuple.1 // Accessing the array of recipes
//            
//            let itemsToDisplay = min(3, categoryRecipes.count)
//            let displayedRecipes = Array(categoryRecipes.prefix(itemsToDisplay))
//            let overlayViewCountNumber = SPTitleLabel(textAlignment: .left, fontSize: 20)
//            let countedNumber = String(categoryRecipes.count - 3)
            
    private func setOverlayView(for cell: RVCollectionViewCell, countedNumber: Int) {
        
            // First remove all subviews
            cell.overlayView.subviews.forEach { $0.removeFromSuperview() }
                let overlayViewCountNumber = SPTitleLabel(textAlignment: .left, fontSize: 20)
                 // Prevent negative count
                if overlayViewCountNumber.superview == nil {
                    
                    cell.overlayView.isHidden = false
                    cell.overlayView.addSubview(overlayViewCountNumber)
                    overlayViewCountNumber.text = "\(countedNumber)+"
                    overlayViewCountNumber.textColor = .white
                    overlayViewCountNumber.heightAnchor.constraint(equalToConstant: 30).isActive = true
                    overlayViewCountNumber.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 45).isActive = true
                    overlayViewCountNumber.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -40).isActive = true
                    overlayViewCountNumber.topAnchor.constraint(equalTo: cell.topAnchor, constant: 35).isActive = true
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

