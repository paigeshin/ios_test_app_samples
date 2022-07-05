//
//  TodoAppIntegrationTests.swift
//  TodoAppIntegrationTests
//
//  Created by Mohammad Azam on 10/17/21.
//

import XCTest

class when_app_is_launched: XCTestCase {
    
    override func setUp() {
        // delete the app
        Springboard.deleteApp()
    }
    
    func test_should_not_display_any_tasks() {
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let taskList = app.tables["taskList"]
        XCTAssertEqual(0, taskList.descendants(matching: .staticText).count)
    }
}


class when_user_saves_a_new_task: XCTestCase {

    override func setUp() {
        // delete the app
        Springboard.deleteApp()
    }
    
    func test_should_be_able_to_save_successfully() {
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
        
        let taskList = app.tables["taskList"]
        XCTAssertEqual(1, taskList.children(matching: .cell).count)
    }
    
    func test_display_error_message_if_task_title_is_duplicated() {
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
        
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        saveTaskButton.tap()
        
        let messageText = app.staticTexts["messageText"]
        XCTAssertEqual(messageText.label, "Task is already added")
    }
}

class when_user_deletes_a_new_task: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        
        Springboard.deleteApp()
        
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
    }
    
    func test_should_delete_task_successfully() {
       
        // get the cell you want to delete
        let cell = app.tables["taskList"].cells["Mow the lawn, Medium"].children(matching: .other).element(boundBy: 0)
        cell.tap()
        cell.swipeLeft()
        app.tables["taskList"].buttons["Delete"].tap()
        XCTAssertFalse(cell.exists)
    }
    
}

class when_user_marks_task_as_favorite: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        
        Springboard.deleteApp()
        
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
    }
    
    func test_should_display_updated_task_on_screen() {
                
        app.tables["taskList"].cells["Mow the lawn, Medium"].children(matching: .other).element(boundBy: 0).tap()
        app.images["favoriteImage"].tap()
        app.buttons["closeButton"].tap()
        
        // now check if the task has been updated
        XCTAssertTrue(app.tables["taskList"].cells["Mow the lawn, Love, Medium"].exists)
    }
}
