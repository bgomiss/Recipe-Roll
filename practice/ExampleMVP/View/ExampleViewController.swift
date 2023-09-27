//
//  ExampleViewController.swift
//  practice
//
//  Created by aycan duskun on 22.09.2023.
//

///  HOMEWORK
///
///  1. Please research about Encapsulation concept in Programming Oriented to Objects

import UIKit

class ExampleViewController: UIViewController {
    
    private var presenter: ExamplePresenter?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.red
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let _tableView = UITableView()
        _tableView.dataSource = self
        _tableView.delegate = self
        return _tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ExamplePresenter(view: self)
        view.addSubview(tableView)
        //view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        presenter?.requestWebService()
    }
    
    func update() {
        self.titleLabel.text = presenter?.recipeModel?.title
    }

}

extension ExampleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

extension ExampleViewController: UITableViewDelegate {
    
}
