//
//  TipCalculator.swift
//  TipCalculator
//
//  Created by paige shin on 2022/07/03.
//

import Foundation

enum TipCalculatorError: Error {
    case invalidInput
}

final class TipCalculator {
    
    func calculate(total: Double, tipPercentage: Double) throws -> Double {
        if total < 0 {
            throw TipCalculatorError.invalidInput
        }
        return total * tipPercentage
    }
    
}
