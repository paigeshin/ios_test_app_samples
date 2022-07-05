//
//  NetworkServiceFactory.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/25/21.
//

import Foundation

class NetworkServiceFactory {
    
    static func create() -> NetworkService {
        
        let environment = ProcessInfo.processInfo.environment["ENV"]
        if let environment = environment {
            if environment == "TEST" {
                return MockNetworkService()
            } else {
                return Webservice()
            }
        }
        
        return Webservice()
    }
 
}
