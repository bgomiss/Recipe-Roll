//
//  UIHelper.swift
//  practice
//
//  Created by aycan duskun on 19.03.2023.
//

import UIKit

struct UIHelper {
    
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
    
    let categoryHeaderView              = CategoriesHeaderView()
    
    static func categoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                , heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(75)
                , heightDimension: .absolute(75))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                             , subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                , bottom: 0, trailing: 15)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15
                , bottom: 20, trailing: 15)
                section.orthogonalScrollingBehavior = .continuous
        
            section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "CategoriesHeader", alignment: .top),
        ]
                
                return section
    }
    
    static func recommendationSection()->NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 20, trailing: 15)
        section.orthogonalScrollingBehavior = .continuous
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "RecommendationHeader", alignment: .top)
            ]
        
        return section
    }
}
