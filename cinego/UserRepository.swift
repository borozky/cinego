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
    
    private var users: [User] = [User (id:"1", email: "s3485376@student.rmit.edu.au", username: "s3485376", fullname : "Joshua", orders: []),
                                 User (id:"2", email: "s3526309@student.rmit.edu.au", username: "s3526309", fullname: "Jiahong HE",orders: []),
                                 User (id:"3", email: "joushua@gmail.com", username: "Joushua", fullname: "Joushua He", orders: []),
                                 User (id:"4", email: "jiahonghe@gmial.com", username: "Jiahong", fullname: "Sara HE", orders: []),
                                 User (id:"5", email: "sara@gmail.com", username: "Sara", fullname: "Sara Jiahong", orders: []),
                                 User (id:"6", email: "bob@gmail.com", username: "Bob", fullname: "Bob the Builder", orders: []),
                                  User (id:"7", email: "angie@gmai.com", username: "Angie", fullname: "Angie Lee", orders: []),
                                  User (id:"8", email: "david@gmai.com", username: "David", fullname: "David Lee", orders: []),
                                  User (id:"9", email: "helloword@gmail.com", username: "Hello", fullname: "Hello Word", orders: []),
                                  User (id:"10", email: "connie@gmai.com", username: "Connie", fullname: "Connie Lee", orders: [])
                                 ]

    func find(byId id: Int) -> User? {
        return users.filter { $0.id == String(id) }.first ?? nil
    }
    
    func find(byUsername username: String) -> User? {
        return users.filter { $0.username == username }.first ?? nil

    }
    
    func find(byEmail email: String) -> User? {
        return users.filter { $0.email == email }.first ?? nil
    }
    
    func create(user: User) -> User? {
        let foundUserByUsername = find(byUsername: user.username)
        if foundUserByUsername == nil {
            users.append(user)
            user.id = String(users.count)
            return user
        }
        return nil
    }
    
    func update(user: User) -> User? {
        for (key, userItem) in users.enumerated() {
            if user.username == userItem.username {
                users[key] = user
                return user
            }
        }
        return nil
    }
    
    func delete(user: User) -> Bool {
        for (key, userItem) in users.enumerated() {
            if user.username == userItem.username {
                users.remove(at: key)
                return true
            }
        }
        return false
    }
    
}
