//
//  CategoriesCollectionView.swift
//  practice
//
//  Created by aycan duskun on 16.03.2023.
//

import UIKit

class homeVCTableViewCell: UITableViewCell {
    
    static let reuseID                  = "TableViewCell"
    let text                            = SPTextField()
    //let categoryView                  = UIView(frame: .zero)
    var categoriesCollectionView        : UICollectionView!
    var recommendationCollectionView    : UICollectionView!
    let layout                          = UICollectionViewFlowLayout()
    let categoriesHeaderTitle           = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let recommendationHeaderTitle       = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let categoriesSeeAllButton          = SPButton(backgroundColor: .clear, title: "See All")
    let recommendationSeeAllButton      = SPButton(backgroundColor: .clear, title: "See All")
    var recipes: [Recipes]              = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recommendationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        configure()
        configureRecommendationCollectionView()
        configureCategoriesCollectionView()
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        recommendationCollectionView.delegate = self
        
        categoriesHeaderTitle.text = "Categories"
        recommendationHeaderTitle.text = "Recommendation"
        //contentView.backgroundColor = .systemYellow
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(categoriesCollectionView, recommendationCollectionView, categoriesHeaderTitle, categoriesSeeAllButton, recommendationHeaderTitle, recommendationSeeAllButton)
      
        NSLayoutConstraint.activate([
            
            categoriesHeaderTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoriesHeaderTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoriesHeaderTitle.heightAnchor.constraint(equalToConstant: 30),
            
            categoriesSeeAllButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            categoriesSeeAllButton.heightAnchor.constraint(equalToConstant: 28),
            categoriesSeeAllButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            
            recommendationHeaderTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            recommendationHeaderTitle.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor),
            recommendationHeaderTitle.heightAnchor.constraint(equalToConstant: 30),
            
            recommendationSeeAllButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            recommendationSeeAllButton.heightAnchor.constraint(equalToConstant: 28),
            recommendationSeeAllButton.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor)
        ])
    }
    
    
    private func configureCategoriesCollectionView() {
//        categoriesCollectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: contentView))
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
                    switch sectionIndex {
                    case 0 :
                        return UIHelper.categoriesSection()
                    case 1 :
                        break
                    default:
                        return
                    }
                }
                collectionView.setCollectionViewLayout(layout, animated: true)

        contentView.addSubview(categoriesCollectionView)
        
        categoriesCollectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.reuseID)
       
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                categoriesCollectionView.topAnchor.constraint(equalTo: categoriesHeaderTitle.bottomAnchor, constant: 3),
                categoriesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                categoriesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                categoriesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -280)
            ])
    }
    
    
    private func configureRecommendationCollectionView() {
//        recommendationCollectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: contentView))
//        contentView.addSubview(recommendationCollectionView)
//        
//        recommendationCollectionView.register(RecommendationCollectionViewCell.self, forCellWithReuseIdentifier: "RecommendationCell")

        recommendationCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recommendationCollectionView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 25),
            recommendationCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recommendationCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recommendationCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -140),
            ])
    }
    
}

extension homeVCTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let categoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reuseID, for: indexPath) as! CategoriesCollectionViewCell
            
            if recipes.isEmpty == false {
                let category = recipes[indexPath.row]
                categoriesCell.set(category: category)
            }
            
            return categoriesCell
            
        } else {
            
            let recommendationCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.reuseID, for: indexPath) as! RecommendationCollectionViewCell
            
            if recipes.isEmpty == false {
                let category = recipes[indexPath.row]
                recommendationCell.set(category: category)
            }
            return recommendationCell
        }
        
    }
}