//
//  UserPostTableViewCell.swift
//  PostFeed
//
//  Created by Aleksandr on 05.05.2025.
//

import UIKit

class UserPostTableViewCell: UITableViewCell {

    private let cardView = UIView()
    private let postTitleLabel = UILabel()
    private let postDescriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear // чтобы между ячейками не было белого
        selectionStyle = .none
        
        // Настройка cardView
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.06
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 6
        cardView.layer.masksToBounds = false

        contentView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false

        // Настройка лейблов
        postTitleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        postTitleLabel.textColor = .systemBlue
        postTitleLabel.numberOfLines = 1

        postDescriptionLabel.font = .systemFont(ofSize: 17, weight: .bold)
        postDescriptionLabel.textColor = .black
        postDescriptionLabel.numberOfLines = 0

        [postTitleLabel, postDescriptionLabel].forEach {
            cardView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            postTitleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            postTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            postTitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),

            postDescriptionLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 10),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            postDescriptionLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12)
        ])
    }

    func configure(with post: Post) {
        postTitleLabel.text = "Title"
        postDescriptionLabel.text = post.body
    }
}
