//
//  UserRepository.swift
//  cinego
//
//  Created by Joshua Orozco on 8/15/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation


protocol IUserRepository {
    func find(byId id: Int) -> User?
    func find(byUsername username: String) -> User?
    func find(byEmail email: String) -> User?
    
    func create(user: User) -> User?
    func update(user: User) -> User?
    func delete(user: User) -> Bool
}

class UserRepository: IUserRepository {
    
    private var users: [User] = [User (id:"1", email: "s3485376@student.rmit.edu.au", username: "s3485376", orders: []),
                                  User (id:"2", email: "s3526309@student.rmit.edu.au", username: "s3526309", orders: []),
                                  User (id:"3", email: "joushua@gmail.com", username: "Joushua", orders: []),
                                  User (id:"4", email: "jiahonghe@gmial.com", username: "Jiahong", orders: []),
                                  User (id:"5", email: "sara@gmail.com", username: "Sara", orders: []),
                                  User (id:"6", email: "bob@gmail.com", username: "Bob", orders: []),
                                  User (id:"7", email: "angie@gmai.com", username: "Angie", orders: []),
                                  User (id:"8", email: "david@gmai.com", username: "David", orders: []),
                                  User (id:"9", email: "helloword@gmail.com", username: "Hello", orders: []),
                                  User (id:"10", email: "connie@gmai.com", username: "Connie", orders: [])
                                 ]

    func find(byId id: Int) -> User? {
     
        return nil;
    }
    
    func find(byUsername username: String) -> User? {
        return nil
    }
    
    func find(byEmail email: String) -> User? {
        return nil
    }
    
    func create(user: User) -> User? {
        return nil
    }
    
    func update(user: User) -> User? {
        return nil
    }
    
    func delete(user: User) -> Bool {
        return false
    }
    
}
