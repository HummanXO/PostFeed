//
//  mainInfoView.swift
//  PostFeed
//
//  Created by Aleksandr on 02.05.2025.
//

import UIKit
import SnapKit

class MainInfoView: UIView {
    
    private let nameTextField = UITextField()
    private let separatorView = UIView()
    private let userNameTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = .white
        layer.cornerRadius = 8
        
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [ .foregroundColor: UIColor.black ]
        )
        nameTextField.borderStyle = .none
        nameTextField.font = .systemFont(ofSize: 17, weight: .light)
        nameTextField.textColor = .black
        
        separatorView.backgroundColor = .systemGray6
        
        userNameTextField.attributedPlaceholder = NSAttributedString(
            string: "UserName",
            attributes: [ .foregroundColor: UIColor.black ]
        )
        userNameTextField.font = .systemFont(ofSize: 17, weight: .light)
        userNameTextField.borderStyle = .none
        userNameTextField.textColor = .black
        
        [nameTextField, separatorView, userNameTextField].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameTextField.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -10),
            
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            userNameTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
            userNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            userNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            userNameTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
    }
    
    public func getName() -> String {
        return nameTextField.text ?? ""
    }
    
    public func getUserName() -> String {
        return userNameTextField.text ?? ""
    }

}
