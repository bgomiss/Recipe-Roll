//
//  ViewController.swift
//  practice
//
//  Created by aycan duskun on 12.03.2023.
//

import UIKit


class HomeVC: UIViewController {
    
    let titleLabel                      = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let queryTextField                  = SPTextField()
    var recipes: [Recipes]              = []
    //let text                           = SPTextField()
    let categoryHeaderView              = CategoriesHeaderView()
    //let layout                         = UICollectionViewFlowLayout()
    let recommendationHeaderTitle       = SPTitleLabel(textAlignment: .left, fontSize: 20)
    
    let recommendationSeeAllButton      = SPButton(backgroundColor: .clear, title: "See All")
    
    
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
        getCategories(query: "pasta")
        configureUIElements()
        configure()
        createDismissKeyboardTapGesture()
        recommendationHeaderTitle.text = "Recommendation"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        queryTextField.text = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func getCategories(query: String) {
        NetworkManager.shared.getCategoriesInfo(for: query) { [weak self] category in
            
            guard let self = self else { return }
            
            switch category {
            case .success(let categories):
                self.updateUI(with: categories)
            case .failure(let error):
                return
            }
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
        //view.addSubviews(categoryHeaderView, recommendationHeaderTitle, recommendationSeeAllButton)
      
        NSLayoutConstraint.activate([
            
//            recommendationHeaderTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            recommendationHeaderTitle.topAnchor.constraint(equalTo: categoriesHeaderTitle.bottomAnchor, constant: 95),
//            recommendationHeaderTitle.heightAnchor.constraint(equalToConstant: 30),
//
//            recommendationSeeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            recommendationSeeAllButton.heightAnchor.constraint(equalToConstant: 28),
//            recommendationSeeAllButton.topAnchor.constraint(equalTo: categoriesSeeAllButton.bottomAnchor, constant: 95)
        ])
    }
    
    
    func updateUI(with categories: [Recipes]) {
        recipes.append(contentsOf: categories)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            //self.view.bringSubviewToFront(self.tableView)
        }
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    func configureUIElements() {
        titleLabel.text = "What would you like to cook today?"
    }
    
    func layoutUI() {
        queryTextField.delegate = self
        
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

