//
//  UIHelper.swift
//  practice
//
//  Created by aycan duskun on 19.03.2023.
//

import UIKit

enum UIHelper {
    
//    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
//        let width = view.bounds.width
//        let padding: CGFloat = 10
//        let minimumItemSpacing: CGFloat = 10
//        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
//        let itemWidth = availableWidth / 6
//
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
//        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
//
//        return flowLayout
 //   }
    
    static func categoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                , heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(75)
                , heightDimension: .absolute(90))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                , subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                , bottom: 0, trailing: 15)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
                , bottom: 10, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
    }
}
