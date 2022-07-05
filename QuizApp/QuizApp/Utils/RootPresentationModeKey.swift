//
//  RootPresentationModeKey.swift
//  QuizApp
//
//  Created by Mohammad Azam on 10/27/21.
//

import Foundation
import SwiftUI 

typealias RootPresentationMode = QuizViewModel?

private struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(nil)
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}

extension RootPresentationMode {
    mutating func dismiss() {
        self = nil 
    }
}
