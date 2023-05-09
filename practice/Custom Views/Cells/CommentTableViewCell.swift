//
//  CommentTableViewCell.swift
//  practice
//
//  Created by aycan duskun on 9.05.2023.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    let userImageView = SPImageView(cornerRadius: 20)
    let commentLabel = SPBodyLabel(frame: .zero)
    static let reuseID = "CommentCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubviews(userImageView, commentLabel)
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),
            
            commentLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            commentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            commentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
}
