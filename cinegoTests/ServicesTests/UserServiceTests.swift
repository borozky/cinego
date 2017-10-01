//
//  UserServiceTests.swift
//  cinego
//
//  Created by Josh MacDev on 24/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import XCTest
import PromiseKit
import Firebase
@testable import cinego

class UserServiceTests: XCTestCase {
    
    var userService: IUserService!
    
    override func setUp() {
        super.setUp()
        self.userService = UserService(firebaseUserService: MockFirebaseUserService())
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_loginWithValidCredentials_Pass() {
        let ex = expectation(description: "")
        
        userService.login(email: "borozky@me.com", password: "1234567890").then { firebaseUser -> Void in
            XCTAssertNotNil(firebaseUser)
        }.catch { error in
            XCTFail()
        }.always { ex.fulfill() }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_loginWithInvalidCredential_Fails() {
        let ex = expectation(description: "")
        userService.login(email: "sara.he@gmail.com", password: "--------").then { firebaseUser -> Void in
            XCTFail()
        }.catch { error in
           XCTAssert(true)
        }.always { ex.fulfill() }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_registration(){
        let ex = expectation(description: "Valid registration should pass")
        let email = "someone@gmail.com"
        let password = "someone"
        let fullname = "Someone"
        let username = "someone"
        
        userService.register(email: email, password: password, fullname: fullname, username: username)
        .then { user -> Void in
            XCTAssertEqual(user.email, email)
            XCTAssertEqual(user.fullname, fullname)
        }.catch { error in
            XCTFail("Registration with valid input should be successful")
        }.always { ex.fulfill() }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_invalid_registration(){
        let ex = expectation(description: "invalid registration should fail")
        let email = ""
        let password = ""
        let fullname = ""
        let username = ""
        
        userService.register(email: email, password: password, fullname: fullname, username: username)
            .then { user -> Void in
                XCTFail("Registration with empty details should fail")
            }.catch { error in
                XCTAssertNotNil(error)
            }.always { ex.fulfill() }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    
    func test_registeredUsers_CanLogin(){
        let ex = expectation(description: "If registration is successful, user should be able to login")
        let email = "someone@gmail.com"
        let password = "someone"
        
        userService.register(email: email,
                             password: password,
                             fullname: "Someone",
                             username: "someone")
        .then { _ in
            self.userService.login(email: email, password: password)
        }.then { user in
            XCTAssertEqual(user.email, email)
        }.catch { error in
            XCTFail(error.localizedDescription)
        }.always { ex.fulfill() }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}

