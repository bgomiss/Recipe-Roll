//
//  CommentsHeaderView.swift
//  practice
//
//  Created by aycan duskun on 9.05.2023.
//

import UIKit

class CommentsHeaderView: UITableViewHeaderFooterView {

    
    let userImageView    = SPImageView(cornerRadius: 20)
    let sendIcon         = SPImageView(frame: .zero)
    let commentTextfield = SPTextField(placeholder: "Add a comment")
    
    static let reuseID   = "CommentsHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
        addSubviews(userImageView, commentTextfield)
        
        
        sendIcon.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        sendIcon.image = UIImage(systemName: "paperplane.fill")
        sendIcon.contentMode = .scaleAspectFit
        paddingView.addSubview(sendIcon)
        
        NSLayoutConstraint.activate([
            sendIcon.trailingAnchor.constraint(equalTo: paddingView.trailingAnchor, constant: -20),
            sendIcon.centerYAnchor.constraint(equalTo: paddingView.centerYAnchor)
        ])
        
        commentTextfield.rightView = paddingView
        commentTextfield.rightViewMode = .always
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),
            
           commentTextfield.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
           commentTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
           commentTextfield.topAnchor.constraint(equalTo: topAnchor, constant: 8),
           commentTextfield.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ])
    }

}
