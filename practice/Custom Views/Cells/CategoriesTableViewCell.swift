//
//  CategoriesCollectionView.swift
//  practice
//
//  Created by aycan duskun on 16.03.2023.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    static let reuseID          = "CategoriesTableViewCell"
    let text                    = SPTextField()
    let categoryView            = UIView(frame: .zero)
    var collectionView:         UICollectionView!
    let layout                  = UICollectionViewFlowLayout()
    let headerTitle             = SPTitleLabel(textAlignment: .left, fontSize: 18)
    let seeAllButton            = SPButton(backgroundColor: .systemRed, title: "See All")
    var recipes: [Recipes]      = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        configure()
        configureCollectionView()
//        updateUI(with: destVC.recipes)
        headerTitle.text = "Categories"
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        addSubviews(headerTitle, seeAllButton, collectionView)
      
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            headerTitle.heightAnchor.constraint(equalToConstant: 30),
            
            seeAllButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            seeAllButton.heightAnchor.constraint(equalToConstant: 28),
            seeAllButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        ])
    }
    
    
//    func updateUI(with categories: [Recipes]) {
//        if categories.isEmpty {
//            return
//        } else {
//            destVC.recipes = categories
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//    }
    
    
    private func configureCollectionView() {
        
        collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: contentView))
        
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        
        
        layout.scrollDirection = .horizontal
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCell")

       
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
    }
}

extension CategoriesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCollectionViewCell
        let category = recipes[indexPath.row]
        cell.set(category: category)
        cell.backgroundColor = .systemYellow
        return cell
    }
    
    
}
