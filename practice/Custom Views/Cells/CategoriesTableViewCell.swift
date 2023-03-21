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
    let seeAllButton            = SPButton(backgroundColor: .clear, title: "See All")
    var recipes: [Recipes]      = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        configure()
        configureCollectionView()
        headerTitle.text = "Categories"
        //contentView.backgroundColor = .systemYellow
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(headerTitle, seeAllButton)
      
        NSLayoutConstraint.activate([
            
//            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            //contentView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 15),
            
            headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerTitle.heightAnchor.constraint(equalToConstant: 30),
            
            seeAllButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            seeAllButton.heightAnchor.constraint(equalToConstant: 28),
            seeAllButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        ])
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: contentView))
        contentView.addSubview(collectionView)
        
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 3),
                collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
    }
}

extension CategoriesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCollectionViewCell
        if recipes.isEmpty == false {
            let category = recipes[indexPath.row]
            cell.set(category: category)
        }
        return cell
    }
}
