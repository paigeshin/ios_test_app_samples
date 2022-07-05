//
//  GradeViewModel.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/22/21.
//

import Foundation

class QuizGradeViewModel: ObservableObject {
    
    @Published var grade: GradeViewModel?
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func submitQuiz(submission: QuizSubmission) {
        
        networkService.getQuizById(url: Constants.Urls.quizById(submission.quizId)) { result in
            switch result {
                case .success(let quizDTO):
                    let quiz = Quiz(quizDTO: quizDTO)
                    let grade = quiz.grade(submission: submission)
                    DispatchQueue.main.async {
                        self.grade = GradeViewModel(grade: grade)
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}

struct GradeViewModel {
    
    private let grade: Grade
    
    init(grade: Grade) {
        self.grade = grade
    }
    
    var letter: String {
        grade.letter.uppercased()
    }
    
    var score: Int {
        grade.score
    }
    
}
