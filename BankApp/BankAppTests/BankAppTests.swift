//
//  BankAppTests.swift
//  BankAppTests
//
//  Created by Mohammad Azam on 11/10/21.
//

import XCTest
@testable import BankApp

class when_deposit_money_into_bank_account: XCTestCase {

    func test_should_deposit_amount_successfully() {
        let bankAccount = BankAccount(accountNumber: "1234", amount: 100)
        bankAccount.deposit(200)
        XCTAssertEqual(300, bankAccount.balance)
    }

}

class when_withdraw_money_from_bank_account: XCTestCase {
    
    func test_should_withdraw_amount_successfully() {
        
        let bankAccount = BankAccount(accountNumber: "1234", amount: 100)
        try! bankAccount.withdraw(50)
        XCTAssertEqual(50, bankAccount.balance)
    }
    
    
    func test_should_throw_insufficient_balance_exception_when_funds_not_available() {
        
        let bankAccount = BankAccount(accountNumber: "1234", amount: 100)
        
        XCTAssertThrowsError(try bankAccount.withdraw(200), "") { error in
            XCTAssertEqual(error as! BankError, BankError.insufficientFunds)
        }
    }
}

