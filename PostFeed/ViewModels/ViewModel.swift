//
//  ViewModel.swift
//  PostFeed
//
//  Created by Aleksandr on 30.04.2025.
//

import Foundation

class ViewModel {
    let networkManager = NetworkManager()
    
    var users: [User] = [] {
        didSet {
            print("Didset")
            onUsersChanged?()
        }
    }
    
    var onUsersChanged: (() -> Void)?
    var onPostSuccess: ((Post) -> Void)?
    
    func createPost(title: String, body: String) {
        let post = Post(userId: 1, id: 101, title: title, body: body)
        networkManager.postCreatePost(post: post) { result in
            switch result {
            case .success(let post):
                self.onPostSuccess?(post)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchAllUsers() {
        networkManager.fechAllUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteUser(user: User) {
        networkManager.deleteUser(with: user) { [weak self] result in
            switch result {
            case .success:
                self?.fetchAllUsers()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postUser(name: String) {
        let user = User(name: name)
        networkManager.postUser(user: user) { [weak self] result in
            switch result {
            case .success:
                print("Start fetching")
                self?.fetchAllUsers()
            case .failure(let error):
                print(error)
            }
        }
    }
}
