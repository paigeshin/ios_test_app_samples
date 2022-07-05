//
//  Quiz.swift
//  QuizApp
//
//  Created by Mohammad Azam on 11/4/21.
//

import Foundation

struct Grade {
    let letter: String
    let score: Int
}

class Quiz {
    
    let quizId: Int
    let title: String
    let questions: [Question]
    
    init(quizDTO: QuizDTO) {
        self.quizId = quizDTO.quizId
        self.title = quizDTO.title
        self.questions = quizDTO.questions.map(Question.init)
    }
    
    var totalPoints: Int {
        self.questions.reduce(0) { next, question in
            next + question.point
        }
    }
    
    func grade(submission: QuizSubmission) -> Grade {
        
        var submissionTotal = 0
        
        questions.forEach { question in
            let correctChoice = question.choices.first { $0.isCorrect == true }
            let userChoiceId = submission.selectedChoices[question.questionId]
            
            if let correctChoice = correctChoice, let userChoiceId = userChoiceId {
                if correctChoice.choiceId == userChoiceId {
                    submissionTotal += question.point
                }
            }
        }
        
        let score = (Double(submissionTotal) / Double(totalPoints)) * 100
        let letterGrade = calculateLetterGrade(score: score)
        return Grade(letter: letterGrade, score: Int(score))
        
    }
    
    func calculateLetterGrade(score: Double) -> String {
        
        switch score {
            case 0...59:
                return "F"
            case 60...89:
                return "B"
            case 90...100:
                return "A"
            default:
                return "N/A"
        }
        
    }
    
}

class Question {
    
    let questionId: Int
    let text: String
    let point: Int
    let choices: [Choice]
    
    init(questionDTO: QuestionDTO) {
        self.questionId = questionDTO.questionId
        self.text = questionDTO.text
        self.point = questionDTO.point
        self.choices = questionDTO.choices.map(Choice.init)
    }
}

class Choice {
    
    let choiceId: Int
    let text: String
    let isCorrect: Bool
    
    init(choiceDTO: ChoiceDTO) {
        self.choiceId = choiceDTO.choiceId
        self.text = choiceDTO.text
        self.isCorrect = choiceDTO.isCorrect
    }
    
}
