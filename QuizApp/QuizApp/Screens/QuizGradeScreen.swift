//
//  GradeScreen.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/22/21.
//

import SwiftUI

struct QuizGradeScreen: View {
    
    @StateObject private var quizGradeVM = QuizGradeViewModel(networkService: NetworkServiceFactory.create())
    let submission: QuizSubmission
    let quiz: QuizViewModel
    @State private var startOver: Bool = false
    @Environment(\.rootPresentationMode) var rootPresentationMode
    
    var body: some View {
        VStack {
            Spacer()
            
            if let grade = quizGradeVM.grade {
                VStack(spacing: 50) {
                    Text("Final Grade")
                    Text(grade.letter)
                        .font(.system(size: 52))
                }
            } else {
                ProgressView("Calculating grade...")
            }
            
            Spacer()
            Button("Start over") {
                rootPresentationMode.wrappedValue.dismiss()
            }
            
        }.navigationTitle(quiz.title)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                quizGradeVM.submitQuiz(submission: submission)
            }
    }
}

struct GradeScreen_Previews: PreviewProvider {
    static var previews: some View {
        let submission = QuizSubmission(quizId: 1)
        let quiz = QuizData.loadQuizes()[0]
        NavigationView {
            QuizGradeScreen(submission: submission, quiz: quiz)
        }
    }
}
