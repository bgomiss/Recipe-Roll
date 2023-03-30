//
//  ShopListVC.swift
//  practice
//
//  Created by aycan duskun on 13.03.2023.
//

import UIKit

class BookmarksVC: UIViewController {
    
    let queryTextField                  = SPTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(queryTextField)
        view.backgroundColor = .systemBackground
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        queryTextField.text = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
