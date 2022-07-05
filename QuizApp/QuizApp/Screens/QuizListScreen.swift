//
//  QuizListScreen.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/21/21.
//

import SwiftUI

struct QuizListScreen: View {
    
    @State private var isActive: Bool = false
    @StateObject private var quizListVM = QuizListViewModel(networkService: NetworkServiceFactory.create())
    @State private var selectedQuiz: QuizViewModel?

    var body: some View {
        
        NavigationView {
            
            List(quizListVM.quizes) { quiz in
               
                NavigationLink(tag: quiz, selection: $selectedQuiz) {
                    QuestionListScreen(quiz: quiz, quizSubmission: QuizSubmission(quizId: quiz.quizId))
                } label: {
                    Text(quiz.title)
                }

            }
            .accessibilityIdentifier("quizList")
            .onAppear {
                quizListVM.populateAllQuizes()
            }
            .navigationTitle("Quizes")
        }.environment(\.rootPresentationMode, $selectedQuiz)
    }
}

struct QuizListScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuizListScreen()
    }
}
