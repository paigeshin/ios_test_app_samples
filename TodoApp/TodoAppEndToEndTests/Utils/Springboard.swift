//
//  Springboard.swift
//  TodoAppEndToEndTests
//
//  Created by paige shin on 2022/07/03.
//

import Foundation
import XCTest

// Responsibilities
// Launch Application - Springboard
// Delete App
class Springboard {
    
    // springboard => Launch Application(springboard), Delete App
    static let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    class func deleteApp() {
        
        // kill application
        XCUIApplication().terminate()
        // activate springboard to delete app 
        springboard.activate()
        
        // find app and press
        let appIcon = springboard.icons.matching(identifier: "TodoApp").firstMatch // My App Name
        appIcon.press(forDuration: 1.3) // press
    
        // find remove app button and press it
        _ = springboard.alerts.buttons["Remove App"].waitForExistence(timeout: 1.0)
        springboard.buttons["Remove App"].tap()
        
        // find delete app button
        let deleteButton = springboard.alerts.buttons["Delete App"].firstMatch
        if deleteButton.waitForExistence(timeout: 5) {
            deleteButton.tap()
            springboard.alerts.buttons["Delete"].tap()
        }
        
    }
    
}
