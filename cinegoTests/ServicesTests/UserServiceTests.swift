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
enum MockFirebaseError : Error {
    case InvalidCredentials(String)
    case NotFound(String)
}

class MockFirebaseUserService: IFirebaseUserService {
    var currentUser: FirebaseUser?
    
    var arrayOfFirebaseUsers: [FirebaseUser] = [
        FirebaseUser(uid: "12345", email: "borozky@me.com"),
        FirebaseUser(uid: "12346", email: "sara.he@gmail.com")
    ]
    var emailPasswordCombination = [
        "borozky@me.com": "1234567890",
        "sara.he@gmail.com": "0987654321"
    ]
    var userDetails: [String: [String: Any]] = [
        "borozky@me.com": [
            "fullname": "Joshua Orozco",
            "username": "borozky"
        ],
        "sara.he@gmail.com": [
            "fullname": "Jiahong He",
            "username": "sarahe"
        ],
    ]
    
    func login(email: String, password: String) -> Promise<FirebaseUser> {
        return Promise { fulfill, reject in
            guard let foundUser = arrayOfFirebaseUsers.first(where: { $0.email! == email }) else {
                reject(MockFirebaseError.NotFound("User not found"))
                return
            }
            guard self.emailPasswordCombination[email] == password else {
                reject(MockFirebaseError.InvalidCredentials("Invalid Credentials"))
                return
            }
            self.currentUser = foundUser
            fulfill(self.currentUser!)
        }
    }
    func logout() -> Promise<Void> {
        return Promise { fulfill, reject in fulfill() }
    }
    
    func register(email: String, password: String) -> Promise<FirebaseUser> {
        let newUser = FirebaseUser(uid: String( 12345 + arrayOfFirebaseUsers.count ), email: email)
        arrayOfFirebaseUsers.append(newUser)
        emailPasswordCombination[email] = password
        self.currentUser = newUser
        return Promise(value: newUser)
    }
    
    func addUserDetail(key: String, value: Any) -> Promise<(String, Any)> {
        return Promise { fulfill, reject in
            if let email = self.currentUser?.email {
                if self.userDetails[email] == nil {
                    self.userDetails[email] = [String: Any]()
                }
                self.userDetails[email]?[key] = value
                fulfill((key, value))
            } else {
                reject(FirebaseServiceError.Unauthorized("Unauthorized"))
            }
            
        }
    }
    
    func getProfileDetails() -> Promise<[String : Any?]> {
        return Promise { fulfill, reject in
            guard let currentUser = self.currentUser else {
                reject(FirebaseServiceError.Unauthorized("User unauthorized"))
                return
            }
            let currentEmail = currentUser.email!
            let userDetails = self.userDetails[currentEmail]!
            fulfill(userDetails)
        }
    }
    
    func getDatabaseReference() -> DatabaseReference {
        return DatabaseReference()
    }
}
