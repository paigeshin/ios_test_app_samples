//
//  Webservice.swift
//  MockingDemo
//
//  Created by Mohammad Azam on 10/11/21.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
    case notAuthenticated
}

protocol NetworkService {
    func login(username: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
}

class Webservice: NetworkService {
    
    func login(username: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        
        let url = URL(string: "https://mango-persistent-organ.glitch.me/login")!
        
        let data = ["username": username, "password": password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(data)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                      completion(.failure(.badRequest))
                      return
                  }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.decodingError))
                return 
            }
            
            if loginResponse.success {
                completion(.success(()))
            } else {
                completion(.failure(.notAuthenticated))
            }
            
        }.resume()
    }
    
}
