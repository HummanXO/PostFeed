//
//  UserPostsViewController.swift
//  PostFeed
//
//  Created by Aleksandr on 01.05.2025.
//

import UIKit

class UserPostsViewController: UIViewController {
    
    private let viewModel: ViewModel
    private let userId: Int
    private let postTableView = UITableView()
    
    init(viewModel: ViewModel, userId: Int) {
        self.viewModel = viewModel
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUI()
    }
    
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.backgroundColor = .white
        
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        postTableView.backgroundColor = .systemGray6
        postTableView.dataSource = self
        postTableView.delegate = self
        postTableView.separatorStyle = .none
        postTableView.register(UserPostTableViewCell.self, forCellReuseIdentifier: "UserPostTableViewCell")
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postTableView)
        
        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension UserPostsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = viewModel.posts[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserPostTableViewCell", for: indexPath) as! UserPostTableViewCell
        cell.configure(with: post)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        return spacer
    }
}
