//
//  MockNetworkService.swift
//  QuizAppUserInterfaceTests
//
//  Created by Mohammad Azam on 11/5/21.
//

import Foundation

class MockNetworkService: NetworkService {
    
    func getAllQuizes(url: URL, completion: @escaping (Result<[QuizDTO], NetworkError>) -> Void) {
        let quizesDTO = QuizData.loadQuizDTOs()
        completion(.success(quizesDTO))
    }
    
    func getQuizById(url: URL, completion: @escaping (Result<QuizDTO, NetworkError>) -> Void) {
        
        let quizesDTO = QuizData.loadQuizDTOs()
        let quizDTO = quizesDTO.first { $0.quizId == 1 }!
        
        completion(.success(quizDTO))
    }
    
}
