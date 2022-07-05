//
//  QuizAppUserInterfaceTests.swift
//  QuizAppUserInterfaceTests
//
//  Created by Mohammad Azam on 11/5/21.
//

import XCTest

class when_app_is_launched: XCTestCase {
    
    func test_should_display_available_quizzes() {
        
        let app = XCUIApplication()
        app.launchEnvironment = ["ENV": "TEST"]
        continueAfterFailure = false
        app.launch()
        let quizList = app.tables["quizList"]
        XCTAssertEqual(2, quizList.cells.count)
    }
   
    
    
}


class when_user_taps_on_a_quiz: XCTestCase {
    
    func test_should_display_questions_for_the_selected_quiz() {
        let app = XCUIApplication()
        app.launchEnvironment = ["ENV": "TEST"]
        continueAfterFailure = false
        app.launch()
        
        let quizList = app.tables["quizList"]
        quizList.cells["Math 101"].tap()
        
        let _ = app.tables["questionList"].waitForExistence(timeout: 2.0)
        XCTAssertEqual(3, app.tables["questionList"].cells.count)
    }
    
}

class when_user_submit_quiz_without_answering_all_questions: XCTestCase {
    
    func test_should_display_error_message_on_the_screen() {
        let app = XCUIApplication()
        app.launchEnvironment = ["ENV": "TEST"]
        continueAfterFailure = false
        app.launch()
        
        let quizList = app.tables["quizList"]
        quizList.cells["Math 101"].tap()
        
        let _ = app.buttons["submitQuizButton"].waitForExistence(timeout: 2.0)
        
        app.buttons["submitQuizButton"].tap()
        
        XCTAssertEqual(Constants.Messages.quizSubmissonFailed, app.staticTexts["messageText"].label)
    }
    
}

class when_user_submits_quiz: XCTestCase {
    
    func test_should_navigate_to_the_grade_screen_and_display_their_grade() {
        
        let app = XCUIApplication()
        app.launchEnvironment = ["ENV": "TEST"]
        continueAfterFailure = false
        app.launch()
        
        let quizList = app.tables["quizList"]
        quizList.cells["Math 101"].tap()
        
        let _ = app.tables["questionList"].waitForExistence(timeout: 5.0)
        
        let questionListTable = app.tables["questionList"]
        questionListTable.cells["1, What is 2+2?, Square, 3, Square, 4, Square, 22, Square, 6"]
            .descendants(matching: .image)
            .element(boundBy: 1)
            .tap()
        questionListTable.cells["2, What is 5+2?, Square, 3, Square, 4, Square, 7, Square, 6"]
            .descendants(matching: .image)
            .element(boundBy: 2)
            .tap()
        questionListTable.cells["3, What is 10+5?, Square, 3, Square, 4, Square, 7, Square, 15"]
            .descendants(matching: .image)
            .element(boundBy: 3)
            .tap()
    
        app.buttons["submitQuizButton"].tap()
        XCTAssertTrue(app.staticTexts["A"].waitForExistence(timeout: 2.0))
        
    }
    
}
