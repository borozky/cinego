//
//  UserService.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit

import FirebaseAuth

protocol IUserService {
    func login(email: String, password: String) -> Promise<User>
    func register(email: String, password: String, fullname: String, username: String) -> Promise<User>
    func logout() -> Promise<Void>
    func getCurrentUser() -> Promise<User>
}

struct ValidationError: Error {
    let message: String
    init(_ message: String) {
        self.message = message
    }
    public var localizedDescription: String {
        return message
    }
}

class UserService: IUserService {
    
    var firebaseUserService: IFirebaseUserService
    init(firebaseUserService: IFirebaseUserService){
        self.firebaseUserService = firebaseUserService
    }
    
    // Gets current user from Firebase
    func getCurrentUser() -> Promise<User> {
        return when(fulfilled:
            firebaseUserService.getCurrentUser(),
            firebaseUserService.getProfileDetails()
        ).then { firebaseUser, details in
            let email = firebaseUser.email!
            let id = firebaseUser.uid
            
            let fullnameDetails = (details["fullname"] ?? nil) ?? ""
            let usernameDetails = (details["username"] ?? nil) ?? ""
            
            let fullname = String(describing: fullnameDetails)
            let username = String(describing: usernameDetails)
            let user = User(id: id, username: username, email: email, fullname: fullname, password: "", bookings: [])
            return Promise(value: user)
        }
    }
    
    // Login with credentials
    func login(email: String, password: String) -> Promise<User> {
        return firebaseUserService.login(email: email, password: password)
        .then {
            when(fulfilled: Promise(value: $0), self.firebaseUserService.getProfileDetails())
        }.then { firebaseUser, details in
            let userID = firebaseUser.uid
            let email = firebaseUser.email!
            
            let fullnameDetails = (details["fullname"] ?? nil) ?? ""
            let usernameDetails = (details["username"] ?? nil) ?? ""
            
            let fullname = String(describing: fullnameDetails)
            let username = String(describing: usernameDetails)
            let password = ""
            let bookings = [Booking]()
            
            let user = User(id: userID,
                            username: username,
                            email: email,
                            fullname: fullname,
                            password: password,
                            bookings: bookings)
            return Promise(value: user)
        }
    }
    
    // Register will email, password, fullname and username, validates early
    func register(email: String, password: String, fullname: String, username: String) -> Promise<User> {
        guard fullname.characters.count > 1 else {
            return Promise(error: ValidationError("Fullname should be at least 1 character"))
        }
        guard email.characters.count > 0 else {
            return Promise(error: ValidationError("Email is required"))
        }
        guard username.characters.count >= 6 else {
            return Promise(error: ValidationError("Username must be at least 6 characters"))
        }
        guard password.characters.count >= 6 else {
            return Promise(error: ValidationError("Password should be at least 6 characters"))
        }
        guard validateEmail(candidate: email) else {
            return Promise(error: ValidationError("\(email) is not a valid email"))
        }
        
        return firebaseUserService.register(email: email, password: password).then { firebaseUser in
            when(fulfilled: Promise(value: firebaseUser), self.firebaseUserService.addUserDetail(key: "fullname", value: fullname))
        }.then { firebaseUser, details in
            when(fulfilled: Promise(value: firebaseUser), self.firebaseUserService.addUserDetail(key: "username", value: username))
        }.then { firebaseUser, details in
            let userID = firebaseUser.uid
            let email = firebaseUser.email!
            let user = User(id: userID, username: username, email: email, fullname: fullname, password: "", bookings: [])
            return Promise(value: user)
        }
    }
    
    // Logout
    func logout() -> Promise<Void> {
        return firebaseUserService.logout()
    }
    
    // Email validation
    // FROM http://emailregex.com/
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
}









