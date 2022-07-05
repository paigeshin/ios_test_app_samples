//
//  NetworkServiceFactory.swift
//  MockingDemo
//
//  Created by paige shin on 2022/07/03.
//

import Foundation

final class NetworkServiceFactory {
    
    static func create() -> NetworkService {
        let environment = ProcessInfo.processInfo.environment["ENV"]
        
        if let environment = environment {
            if environment == "TEST" {
                return MockWebservice()
            } else {
                return Webservice()
            }
        } else{
             return Webservice()
        }
    }
    
}
