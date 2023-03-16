//
//  CategoriesCollectionView.swift
//  practice
//
//  Created by aycan duskun on 16.03.2023.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    static let reuseID = "CategoriesTableViewCell"
    let categoryView = UIView(frame: .zero)
    var collectionView: UICollectionView!
    let headerTitle = SPTitleLabel(textAlignment: .left, fontSize: 18)
    let seeAllButton = SPButton(backgroundColor: .systemMint, title: "See All")
    var recipes: [Recipes] = []
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureCollectionView()
        headerTitle.text = "Categories"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(headerTitle, seeAllButton)
        
        NSLayoutConstraint.activate([
            
            
            headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: -32),
            headerTitle.heightAnchor.constraint(equalToConstant: 30),
            
            seeAllButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            seeAllButton.heightAnchor.constraint(equalToConstant: 28),
            seeAllButton.topAnchor.constraint(equalTo: self.topAnchor, constant: -32)
        ])
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        contentView.addSubview(collectionView)
        
        
        layout.scrollDirection = .horizontal
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCell")

       
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
            collectionView.widthAnchor.constraint(equalToConstant: 60),
        ])
        
    }
}

extension CategoriesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCollectionViewCell
        
        return cell
    }
    
    
}
