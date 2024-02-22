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
        
        let itemsToDisplay = min(3, bookmarkedRecipes.count)
        
        switch section {
        case 0:
            return itemsToDisplay
            
        case 1:
            return itemsToDisplay
            
        case 2:
            return itemsToDisplay
            
        case 3:
            return itemsToDisplay
            
        case 4:
            return itemsToDisplay
            
        default:
            return itemsToDisplay
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        categoryID.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let categoryID = bookmarkedRecipes[indexPath.section].0
        let categoryRecipes = bookmarkedRecipes[indexPath.section].1
        let itemsToDisplay = min(3, categoryRecipes.count)
        let displayedRecipes = Array(categoryRecipes.prefix(itemsToDisplay))
        let overlayViewCountNumber = SPTitleLabel(textAlignment: .left, fontSize: 20)
        let countedNumber = String(categoryRecipes.count - 3)
        
        
        //let categoryID = getCategoryID(for: indexPath.section)
        
        //        guard let recipes = recipes[categoryID] else {
        //            //print("RECIPES DICTIONARY ITEMS: \(recipes)")
        //            // Handle the case where the category ID is not found in the dictionary
        //            //print("Recipes not found for category: \(categoryID)")
        //            return cell }
        //        guard let index = bookmarkedRecipes.firstIndex(where: { $0.0 == categoryID }) else {
        //            // Handle the case where categoryID is not found
        //            return cell
        //        }
        
        // Access the tuple using the index
        //let tuple = bookmarkedRecipes[index]
        //let categoryRecipes = tuple.1 // Accessing the array of recipes
        //print("Category RECIPES: \(categoryRecipes)")
        
        
        
        
        switch categoryID {
            
        case "Recently Viewed":
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RVCollectionViewCell.reuseID, for: indexPath) as? RVCollectionViewCell else {fatalError("unable to dequeue")}
                
                func setOverlayView() {
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
                if indexPath.item == 2 {
                    
                    setOverlayView()
                    
                } else {
                    cell.overlayView.isHidden = true
                }
                
                // Ensure indexPath.item is within the valid range
                guard indexPath.item >= 0 && indexPath.item < itemsToDisplay else {
                    fatalError("Invalid index path item: \(indexPath.item)")
                }
                
                let category = displayedRecipes[indexPath.item]
                cell.set(category: category)
                
                return cell
            
        case "MadeIt":
            
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MadeItCollectionViewCell.reuseID, for: indexPath) as? MadeItCollectionViewCell else {fatalError("unable to dequeue")}
                
                func setOverlayView() {
                    if overlayViewCountNumber.superview == nil {
                        cell.overlayView?.isHidden = false
                        cell.overlayView?.addSubview(overlayViewCountNumber)
                        overlayViewCountNumber.text = "\(countedNumber)+"
                        overlayViewCountNumber.textColor = .white
                        overlayViewCountNumber.heightAnchor.constraint(equalToConstant: 30).isActive = true
                        overlayViewCountNumber.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 45).isActive = true
                        overlayViewCountNumber.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -40).isActive = true
                        overlayViewCountNumber.topAnchor.constraint(equalTo: cell.topAnchor, constant: 35).isActive = true
                        
                    }
                }
                
                if indexPath.item == 2 {
                    setOverlayView()
                } else {
                    cell.overlayView?.isHidden = true
                }
                
                // Ensure indexPath.item is within the valid range
                guard indexPath.item >= 0 && indexPath.item < itemsToDisplay else {
                    fatalError("Invalid index path item: \(indexPath.item)")
                }
                
                let category = displayedRecipes[indexPath.item]
                cell.set(category: category)
                
                return cell
            
        case "Breakfast":
            
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreakfastCollectionViewCell.reuseID, for: indexPath) as? BreakfastCollectionViewCell else {fatalError("unable to dequeue")}
                
                func setOverlayView() {
                    if overlayViewCountNumber.superview == nil {
                        cell.overlayView?.isHidden = false
                        cell.overlayView?.addSubview(overlayViewCountNumber)
                        overlayViewCountNumber.text = "\(countedNumber)+"
                        overlayViewCountNumber.textColor = .white
                        overlayViewCountNumber.heightAnchor.constraint(equalToConstant: 30).isActive = true
                        overlayViewCountNumber.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 45).isActive = true
                        overlayViewCountNumber.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -40).isActive = true
                        overlayViewCountNumber.topAnchor.constraint(equalTo: cell.topAnchor, constant: 35).isActive = true
                        
                    }
                }
                if indexPath.item == 2 {
                    setOverlayView()
                } else {
                    cell.overlayView?.isHidden = true
                }
                
                // Ensure indexPath.item is within the valid range
                guard indexPath.item >= 0 && indexPath.item < itemsToDisplay else {
                    fatalError("Invalid index path item: \(indexPath.item)")
                }
                
                let category = displayedRecipes[indexPath.item]
                cell.set(category: category)
                
                return cell
            
        case "Lunch":
            
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LunchCollectionViewCell.reuseID, for: indexPath) as? LunchCollectionViewCell else {fatalError("unable to dequeue")}
                
                func setOverlayView() {
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
                
                if indexPath.item == 2 {
                    setOverlayView()
                } else {
                    cell.overlayView.isHidden = true
                }
                
                // Ensure indexPath.item is within the valid range
                guard indexPath.item >= 0 && indexPath.item < itemsToDisplay else {
                    fatalError("Invalid index path item: \(indexPath.item)")
                }
                
                let category = displayedRecipes[indexPath.item]
                cell.set(category: category)
                
                return cell
            
        case "Dinner":
           
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DinnerCollectionViewCell.reuseID, for: indexPath) as? DinnerCollectionViewCell else {fatalError("unable to dequeue")}
                
                func setOverlayView() {
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
                
                if indexPath.item == 2 {
                    setOverlayView()
                } else {
                    cell.overlayView.isHidden = true
                }
                
                // Ensure indexPath.item is within the valid range
                guard indexPath.item >= 0 && indexPath.item < itemsToDisplay else {
                    fatalError("Invalid index path item: \(indexPath.item)")
                }
                
                let category = displayedRecipes[indexPath.item]
                cell.set(category: category)
                
                return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LunchCollectionViewCell.reuseID, for: indexPath) as? LunchCollectionViewCell else {fatalError("unable to dequeue")}
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RVCollectionViewCell.reuseID, for: indexPath) as! RVCollectionViewCell
        return cell
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

