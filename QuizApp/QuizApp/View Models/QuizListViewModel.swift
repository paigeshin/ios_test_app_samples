//
//  QuizListViewModel.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/21/21.
//

import Foundation

class QuizListViewModel: ObservableObject {
    
    @Published var quizes: [QuizViewModel] = []
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func populateAllQuizes() {
        
        networkService.getAllQuizes(url: Constants.Urls.allQuizes) { result in
            switch result {
                case .success(let quizesDTO):
                    DispatchQueue.main.async {
                        self.quizes = quizesDTO.map(QuizViewModel.init)
                    }
                case .failure(let error):
                    print(error)
            }
        }
        
    }
    
}

struct QuizViewModel: Identifiable, Hashable {
    
    static func == (lhs: QuizViewModel, rhs: QuizViewModel) -> Bool {
        return lhs.quizId == rhs.quizId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(quizId)
    }
    
    
    let id = UUID() 
    
    private let quiz: QuizDTO
    
    init(quiz: QuizDTO) {
        self.quiz = quiz
    }
    
    var quizId: Int {
        quiz.quizId
    }
    
    var title: String {
        quiz.title
    }
    
    var questions: [QuestionViewModel] {
        quiz.questions.map(QuestionViewModel.init)
    }
    
}
