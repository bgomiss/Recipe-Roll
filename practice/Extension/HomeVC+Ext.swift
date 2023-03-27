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
        default:
            return recipes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reuseID, for: indexPath) as? CategoriesCollectionViewCell else {fatalError("unable to dequeue")}
            if recipes.isEmpty == false {
                let category = recipes[indexPath.row]
                cell.set(category: category)
            }
            
            return cell
       
        default:
            return UICollectionViewCell()
        }
    }
    
    
}
