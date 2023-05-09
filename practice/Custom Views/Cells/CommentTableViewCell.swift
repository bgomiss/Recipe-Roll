//
//  CommentTableViewCell.swift
//  practice
//
//  Created by aycan duskun on 9.05.2023.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    let userImageView = SPImageView(cornerRadius: 20)
    let commentTextField = SPTextField(placeholder: "Add a comment")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubviews(userImageView, commentTextField)
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),
            
            commentTextField.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            commentTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            commentTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            commentTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
}
