//
//  QuizAppUnitTests.swift
//  QuizAppUnitTests
//
//  Created by Mohammad Azam on 11/4/21.
//

import XCTest
@testable import QuizApp

class when_loading_a_quiz: XCTestCase {

    func test_should_make_sure_quiz_total_points_are_calculated_correctly() {
        
        let quizesDTOs = QuizData.loadQuizDTOs()
        let quizes = quizesDTOs.map(Quiz.init)
        
        let mathQuiz = quizes.first {
            $0.quizId == 1
        }!
        
        XCTAssertEqual(3, mathQuiz.questions.count)
        XCTAssertEqual(30, mathQuiz.totalPoints)
        
    }
}

class when_calculate_student_grade: XCTestCase {
    
    lazy var gradeASubmission: QuizSubmission = {    
        var userSubmission = QuizSubmission(quizId: 1)
        userSubmission.addChoice(questionId: 1, choiceId: 2)
        userSubmission.addChoice(questionId: 2, choiceId: 3)
        userSubmission.addChoice(questionId: 3, choiceId: 4)
        return userSubmission
    }()
    
    lazy var gradeBSubmission: QuizSubmission = {
        var userSubmission = QuizSubmission(quizId: 1)
        userSubmission.addChoice(questionId: 1, choiceId: 1)
        userSubmission.addChoice(questionId: 2, choiceId: 3)
        userSubmission.addChoice(questionId: 3, choiceId: 4)
        return userSubmission
    }()
    
    lazy var gradeFSubmission: QuizSubmission = {
        var userSubmission = QuizSubmission(quizId: 1)
        userSubmission.addChoice(questionId: 1, choiceId: 4)
        userSubmission.addChoice(questionId: 2, choiceId: 2)
        userSubmission.addChoice(questionId: 3, choiceId: 1)
        return userSubmission
    }()
    
    
    func test_calculate_grade_successfully_based_on_student_score() {
        
        let quizesDTOs = QuizData.loadQuizDTOs()
        let quizes = quizesDTOs.map(Quiz.init)
        
        let mathQuiz = quizes.first {
            $0.quizId == 1
        }!
        
        XCTAssertEqual("A", mathQuiz.calculateLetterGrade(score: 90))
        XCTAssertEqual("B", mathQuiz.calculateLetterGrade(score: 72))
        XCTAssertEqual("F", mathQuiz.calculateLetterGrade(score: 42))
    }
    
    func test_calculate_grade_based_on_student_submission() {
        
        let quizesDTO = QuizData.loadQuizDTOs()
        let quizes = quizesDTO.map(Quiz.init)
        
        let mathQuiz = quizes.first {
            $0.quizId == 1
        }!
        
        XCTAssertEqual("A", mathQuiz.grade(submission: gradeASubmission).letter)
        XCTAssertEqual("B", mathQuiz.grade(submission: gradeBSubmission).letter)
        XCTAssertEqual("F", mathQuiz.grade(submission: gradeFSubmission).letter)
    }
    
}
