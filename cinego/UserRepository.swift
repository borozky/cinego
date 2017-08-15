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
    
    func find(byId id: Int) -> User? {
        return nil
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
