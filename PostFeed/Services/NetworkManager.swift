//
//  NetworkManager.swift
//  PostFeed
//
//  Created by Aleksandr on 30.04.2025.
//

import Foundation

class NetworkManager {
    private let baseUrl = URL(string: "http://localhost:3000/")
    
    enum HTTPMethods: String {
    case post
    case put
    case delete
    case get
    }
    
    enum APIs: String {
    case users = "users"
    case posts = "posts"
    case comments = "comments"
    }
    
    func fetchUserPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = baseUrl?.appending(path: APIs.posts.rawValue) else {
            print("Invalid Url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error making Task \(error.localizedDescription)")
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                do {
                    let result = try JSONDecoder().decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                }
                catch {
                    print("Error decoding Data")
                }
            }
        }.resume()
    }
    
    func postCreatePost(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        guard let url = baseUrl?.appendingPathComponent(APIs.posts.rawValue), let data = try? JSONEncoder().encode(post) else {
            print("Invalid Url or encode Data")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethods.post.rawValue.uppercased()
        request.httpBody = data
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error making Task \(error.localizedDescription)")
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 201 {
                do {
                    let responsePost = try JSONDecoder().decode(Post.self, from: data!)
                    DispatchQueue.main.async {
                        completion(.success(responsePost))
                    }
                }
                catch {
                    print("Error decoding Data")
                }
            }
        }.resume()
    }
    
    func fechAllUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = baseUrl?.appendingPathComponent(APIs.users.rawValue) else {
            print("Invalid Url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error making task \(error)")
            }
            
            if let data = data {
                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(users))
                    }
                } catch {
                    print("Error decoding data \(error)")
                }
            }
        }.resume()
    }
    
    func createUser(user: User, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = baseUrl?.appendingPathComponent(APIs.users.rawValue) else {
            print("Invalid Url")
            return
        }
        
        guard let dataToSend = try? JSONEncoder().encode(user) else {
            print("Error encoding data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.post.rawValue.uppercased()
        request.httpBody = dataToSend
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making task \(error)")
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 201 {
                do {
                    let responseData = try JSONDecoder().decode(User.self, from: data!)
                    DispatchQueue.main.async {
                        completion(.success(responseData))
                    }
                }
                catch {
                    print("Error encoding response")
                }
            }
        }.resume()
    }
    
    func deleteUser(with user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        let userId = user.id ?? 0
        guard let url = baseUrl?.appendingPathComponent(APIs.users.rawValue).appendingPathComponent("\(userId)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethods.delete.rawValue.uppercased()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error making Task \(error.localizedDescription)")
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                DispatchQueue.main.async {
                    completion(.success(Void()))
                }
            }
        }.resume()
    }
    
    
}
