//
//  ViewController.swift
//  practice
//
//  Created by aycan duskun on 12.03.2023.
//

import UIKit


class HomeVC: UIViewController {
    
    let titleLabel                      = SPTitleLabel(text: "What would you like to cook today?", textAlignment: .left, fontSize: 20)
    let queryTextField                  = SPTextField(placeholder: "Search for a Delicious Food")
    var recipes: [(tag: String, recipe: [Recipe])]      = []
    let categoryHeaderView              = CategoriesHeaderView()
    let recommendationHeaderTitle       = SPTitleLabel(text: "Recommendation", textAlignment: .left, fontSize: 20)
    
    let recommendationSeeAllButton      = SPButton(backgroundColor: .clear, title: "See All")
    let tags = [Tags.breakfast, Tags.lunch, Tags.dinner, Tags.soup, Tags.dessert]
    let group = DispatchGroup()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.reuseID)
        collectionView.register(RecommendationCollectionViewCell.self, forCellWithReuseIdentifier: RecommendationCollectionViewCell.reuseID)
        collectionView.register(CategoriesHeaderView.self, forSupplementaryViewOfKind: "CategoriesHeader", withReuseIdentifier: CategoriesHeaderView.headerIdentifier)
        collectionView.register(RecommendationHeaderView.self, forSupplementaryViewOfKind: "RecommendationHeader", withReuseIdentifier: RecommendationHeaderView.headerIdentifier)
        collectionView.backgroundColor = .systemBackground
       
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(queryTextField, titleLabel, collectionView)
        configureCompositionalLayout()
        layoutUI()
        recipes = tags.map { (tag: $0, recipe: []) }
        
        for (index, tag) in tags.enumerated() {
            group.enter()
            getCategories(tag: tag, atIndex: index, group: group)
        }
        group.notify(queue: .main) {
            self.collectionView.reloadData()
        }
        configureUIElements()
        configure()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        queryTextField.text = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func getCategories(tag: String, atIndex index: Int, group: DispatchGroup) {
        NetworkManager.shared.getCategoriesInfo(for: tag) { [weak self] category in
            
            guard let self = self else { return }
            
            switch category {
            case .success(let categories):
                self.updateUI(with: categories, atIndex: index)
            case .failure(let error):
                return
            }
            group.leave()
        }
    }
    
//    func getCategories() {
//        PersistenceManager.retrievedCategories { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let categories):
//                self.updateUI(with: categories)
//
//            case .failure(let error):
//                return
//            }
//        }
//    }
    
    func configure() {
        collectionView.setUp(to: view, and: queryTextField)
    }
    
    
    func updateUI(with categories: [Recipe], atIndex index: Int) {

        DispatchQueue.main.async {
            self.recipes[index].recipe = categories
        }
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    func configureUIElements() {
        let searchIcon = UIImage(systemName: "magnifyingglass")
        let imageView = UIImageView(image: searchIcon)
        imageView.contentMode = .scaleAspectFit
        queryTextField.leftViewMode = .always
        queryTextField.leftView = imageView
    }
    
    
    func layoutUI() {
        queryTextField.delegate     = self
        
        NSLayoutConstraint.activate([
            queryTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            queryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            queryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            queryTextField.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            titleLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}


extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        queryTextField.resignFirstResponder()
    }
}

extension HomeVC {
    func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return UIHelper.categoriesSection()
                
            case 1 :
                return UIHelper.recommendationSection()
                
            default:
                return UIHelper.categoriesSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

