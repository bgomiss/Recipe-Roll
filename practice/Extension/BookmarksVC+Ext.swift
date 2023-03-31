//
//  BookmarksVC+Ext.swift
//  practice
//
//  Created by aycan duskun on 30.03.2023.
//

import UIKit

extension BookmarksVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RVCollectionViewCell.reuseID, for: indexPath) as? RVCollectionViewCell else {fatalError("unable to dequeue")}
            if recipes.isEmpty == false {
                let category = recipes[indexPath.row]
                cell.set(category: category)
            }
            
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MadeItCollectionViewCell.reuseID, for: indexPath) as? MadeItCollectionViewCell else {fatalError("unable to dequeue")}
            if recipes.isEmpty == false {
                let category = recipes[indexPath.row]
                cell.set(category: category)
            }
            
            return cell
       
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.reuseID, for: indexPath) as? RecommendationCollectionViewCell else {fatalError("unable to dequeue")}
            if recipes.isEmpty == false {
                let category = recipes[indexPath.row]
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
            
        default:
            fatalError("Unexpected section \(indexPath.section)")
        }
    }
    
}
