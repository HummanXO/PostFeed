//
//  ContactInfoView.swift
//  PostFeed
//
//  Created by Aleksandr on 02.05.2025.
//

import UIKit

class ContactInfoView: UIView {
    
    private let emailTextField = UITextField()
    private let separatorOneView = UIView()
    private let phoneTextField = UITextField()
    private let separatorTwoView = UIView()
    private let websiteTextField = UITextField()
    

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
        
        emailTextField.textColor = .black
        emailTextField.font = .systemFont(ofSize: 17, weight: .light)
        emailTextField.borderStyle = .none
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [
                .foregroundColor: UIColor.black
            ]
        )
        
        separatorOneView.backgroundColor = .systemGray6
        
        phoneTextField.textColor = .black
        phoneTextField.keyboardType = .phonePad
        phoneTextField.font = .systemFont(ofSize: 17, weight: .light)
        phoneTextField.borderStyle = .none
        phoneTextField.attributedPlaceholder = NSAttributedString(
            string: "Phone",
            attributes: [
                .foregroundColor: UIColor.black
            ]
        )
        
        separatorTwoView.backgroundColor = .systemGray6
        
        websiteTextField.textColor = .black
        websiteTextField.font = .systemFont(ofSize: 17, weight: .light)
        websiteTextField.borderStyle = .none
        websiteTextField.attributedPlaceholder = NSAttributedString(
            string: "Website",
            attributes: [
                .foregroundColor: UIColor.black
            ]
        )
        
        [emailTextField, separatorOneView, phoneTextField, separatorTwoView, websiteTextField].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            separatorOneView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            separatorOneView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorOneView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorOneView.heightAnchor.constraint(equalToConstant: 1),

            phoneTextField.topAnchor.constraint(equalTo: separatorOneView.bottomAnchor, constant: 10),
            phoneTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            phoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),

            separatorTwoView.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10),
            separatorTwoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorTwoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorTwoView.heightAnchor.constraint(equalToConstant: 1),

            websiteTextField.topAnchor.constraint(equalTo: separatorTwoView.bottomAnchor, constant: 10),
            websiteTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            websiteTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            websiteTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
    }
    
    public func getEmail() -> String {
        return emailTextField.text ?? ""
    }
    
    public func getPhoneNumber() -> String {
        return phoneTextField.text ?? ""
    }
    public func getWebsite() -> String {
        return websiteTextField.text ?? ""
    }
    
}
