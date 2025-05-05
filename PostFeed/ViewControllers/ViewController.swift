//
//  ViewController.swift
//  PostFeed
//
//  Created by Aleksandr on 30.04.2025.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationBar()
        setupUI()
        viewModel.onUsersChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.onPostSuccess = { post in
            print("Пост успешно отправлен  \(post.title)")
        }
        viewModel.fetchAllUsers()
    }
    
    private func setUpNavigationBar() {
        title = "Post Feed"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add User", style: .plain, target: self, action: #selector(addUserTapted))
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        [tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func addUserTapted() {
        navigationController?.pushViewController(AddUserViewController(viewModel: viewModel), animated: true)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.titleLabel.text = viewModel.users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteUser(user: viewModel.users[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = viewModel.users[indexPath.row].id
        viewModel.fetchUserPosts(userId: userId ?? 0)
        navigationController?.pushViewController(UserPostsViewController(viewModel: viewModel, userId: userId ?? 0), animated: true)
    }
}

