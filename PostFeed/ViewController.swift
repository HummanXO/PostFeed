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
            self?.tableView.reloadData()
        }
        viewModel.onPostSuccess = { post in
            print("Пост успешно отправлен  \(post.title)")
        }
        viewModel.fetchAllUsers()
    }
    
    private func setUpNavigationBar() {
        title = "Post Feed"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapted))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add User", style: .plain, target: self, action: #selector(addUserTapted))
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupUI() {
        tableView.dataSource = self
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
    
    @objc private func addTapted() {
        let alertController = UIAlertController(title: "Add post", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter post title"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Enter post text"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self else { return }
            viewModel.createPost(title: alertController.textFields![0].text ?? "", body: alertController.textFields![1].text ?? "")
        })
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func addUserTapted() {
        navigationController?.present(AddUserViewController(), animated: true)
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
}

