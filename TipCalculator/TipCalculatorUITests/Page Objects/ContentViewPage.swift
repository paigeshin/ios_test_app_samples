//
//  ContentViewPage.swift
//  TipCalculatorUITests
//
//  Created by paige shin on 2022/07/03.
//

import Foundation
import XCTest

class ContentViewPage {
    
    var app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var totalTextField: XCUIElement {
        app.textFields["totalTextField"]
    }
    
    var calculateTipButton: XCUIElement {
        app.buttons["calculateTipButton"]
    }
    
    var tipPercentageSegmentedControl: XCUIElement {
        app.segmentedControls["tipPercentageSegmentedControl"]
    }
 
    var tipText: XCUIElement {
        app.staticTexts["tipText"]
    }
    
    var messageText: XCUIElement {
        app.staticTexts["messageText"]
    }
    
}
