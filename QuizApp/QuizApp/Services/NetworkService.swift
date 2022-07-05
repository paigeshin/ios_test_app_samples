//
//  NetworkService.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/24/21.
//

import Foundation

protocol NetworkService {
    func getAllQuizes(url: URL, completion: @escaping (Result<[QuizDTO], NetworkError>) -> Void)
    func getQuizById(url: URL, completion: @escaping (Result<QuizDTO, NetworkError>) -> Void)
}
