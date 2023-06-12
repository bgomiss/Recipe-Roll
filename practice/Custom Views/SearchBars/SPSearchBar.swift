//
//  File.swift
//  practice
//
//  Created by aycan duskun on 12.06.2023.
//

import UIKit

class SPSearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(placeholder: String?) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        searchBarStyle = .minimal
        tintColor = .systemMint
        barTintColor = .systemBackground
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        let attributedPlaceholder = NSAttributedString(string: "Search for a Delicious Food", attributes: placeholderAttributes)
        self.searchTextField.attributedPlaceholder = attributedPlaceholder
        
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .black
        
        let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
        clearButton?.tintColor = .gray
        
        let cancelButton = self.value(forKey: "cancelButton") as? UIButton
        cancelButton?.setTitleColor(.systemBlue, for: .normal)
    }
}
