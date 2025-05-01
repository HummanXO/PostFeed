//
//  AddUserViewController.swift
//  PostFeed
//
//  Created by Aleksandr on 30.04.2025.
//

import UIKit

class AddUserViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private let nameTextField = UITextField()
    private let sendButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.layer.borderColor = UIColor.black.cgColor
        
        sendButton.setTitle( "Send", for: .normal)
        sendButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        sendButton.titleLabel?.textAlignment = .center
        sendButton.tintColor = .black
        sendButton.backgroundColor = .systemBlue
        sendButton.layer.cornerRadius = 8
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        [nameTextField, sendButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            nameTextField.widthAnchor.constraint(equalToConstant: 200),
            
            sendButton.heightAnchor.constraint(equalToConstant: 44),
            sendButton.widthAnchor.constraint(equalToConstant: 150),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
    }
    
    @objc private func sendButtonTapped() {
        viewModel.postUser(name: nameTextField.text ?? "")
        dismiss(animated: true)
    }

}
