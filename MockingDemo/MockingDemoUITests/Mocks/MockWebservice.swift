//
//  MockWebService.swift
//  MockingDemoUITests
//
//  Created by paige shin on 2022/07/03.
//

import Foundation

class MockWebservice: NetworkService {
    
    func login(username: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        
        if username == "JohnDoe" && password == "Password" {
            completion(.success(()))
        } else {
            completion(.failure(.notAuthenticated))
        }

    }
    
}

