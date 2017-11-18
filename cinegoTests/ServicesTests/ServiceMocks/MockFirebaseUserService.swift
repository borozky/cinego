//
//  MockFirebaseUserService.swift
//  cinego
//
//  Created by Josh MacDev on 25/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit
import Firebase
@testable import cinego

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
    
    func getCurrentUser() -> Promise<FirebaseUser> {
        return Promise(value: self.currentUser!)
    }
    
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
