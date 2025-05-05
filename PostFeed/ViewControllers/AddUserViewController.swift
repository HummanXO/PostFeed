//
//  AddUserViewController.swift
//  PostFeed
//
//  Created by Aleksandr on 30.04.2025.
//

import UIKit

class AddUserViewController: UIViewController {
    
    private let viewModel: ViewModel
    private let mainInfoView = MainInfoView()
    private let contactInfoView = ContactInfoView()
    private let sentButton = UIButton()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUI()
    }
    
    private func setupNavBar() {
        title = "Add User"
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        
        sentButton.setTitle( "Sent", for: .normal)
        sentButton.tintColor = .white
        sentButton.backgroundColor = .systemBlue
        sentButton.layer.cornerRadius = 5
        sentButton.addTarget(self, action: #selector(sentTapted), for: .touchUpInside)
        
        [mainInfoView, contactInfoView, sentButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            mainInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            
            contactInfoView.topAnchor.constraint(equalTo: mainInfoView.bottomAnchor, constant: 10),
            contactInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            contactInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            sentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            sentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sentButton.heightAnchor.constraint(equalToConstant: 55),
            sentButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    @objc private func sentTapted() {
        let user = User(name: mainInfoView.getName(), username: mainInfoView.getName(), email: contactInfoView.getEmail(), phone: contactInfoView.getPhoneNumber(), website: contactInfoView.getWebsite())
        viewModel.createUser(user: user)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
}
