//
//  ViewController.swift
//  practice
//
//  Created by aycan duskun on 12.03.2023.
//

import UIKit


class HomeVC: UIViewController {
   
    let titleLabel = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let queryTextField = SPTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(queryTextField, titleLabel)
        layoutUI()
        configureUIElements()
        createDismissKeyboardTapGesture()
        
        NetworkManager.shared.getResults(for: "pasta") { result in
            
            switch result {
            case .success(let recipes):
                print(recipes)
            case .failure(_):
                break
            }
            
        }
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        queryTextField.text = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
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

