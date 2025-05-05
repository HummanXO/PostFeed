//
//  UserCommentsTableViewCell.swift
//  PostFeed
//
//  Created by Aleksandr on 01.05.2025.
//

import UIKit

class PostCommentsTableViewCell: UITableViewCell {
    
    public let commentLabel = UILabel()
    public let emailLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 8
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        commentLabel.textColor = .black
        commentLabel.font = .systemFont(ofSize: 15, weight: .regular)
        commentLabel.numberOfLines = 3
        commentLabel.textAlignment = .center
        
        emailLabel.font = .systemFont(ofSize: 13, weight: .light)
        emailLabel.textColor = .gray
        emailLabel.numberOfLines = 1
        emailLabel.textAlignment = .left
        
        [commentLabel, emailLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            commentLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -5),
            
            emailLabel.leftAnchor.constraint(equalTo: commentLabel.leftAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
}
