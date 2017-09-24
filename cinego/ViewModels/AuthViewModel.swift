//
//  LoginViewModel.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol AuthViewModelDelegate: class {
    func userLoggedIn(_ user: User) -> Void
    func userRegistered(_ user: User) -> Void
    func userLoggedOut() -> Void
    func loginError(_ message: String) -> Void
    func registrationError(_ message: String) -> Void
    func logoutError(_ message: String) -> Void
}

class AuthViewModel {
    weak var delegate: AuthViewModelDelegate?
    var currentUser: User? {
        didSet {
            if let user = self.currentUser {
                self.delegate?.userLoggedIn(user)
            } else {
                self.delegate?.userLoggedOut()
            }
        }
    }
    
    var userService: IUserService
    init(userService: IUserService){
        self.userService = userService
    }
    
    func checkAuth() {
        userService.getCurrentUser().then {
            self.currentUser = $0
        }.always {}
    }
    
    func login(_ email: String, _ password: String){
        userService.login(email: email, password: password).then { user in
            self.currentUser = user
        }.catch { error in
            self.delegate?.loginError(error.localizedDescription)
        }
    }
    
    func register(email: String, password: String, passwordConfirmation: String, username: String, fullname: String){
        guard fullname != "" else {
            delegate?.registrationError("Fullname cannot be blank")
            return
        }
        
        guard username != "" else {
            delegate?.registrationError("Username cannot be blank")
            return
        }
        
        guard email != "" else {
            delegate?.registrationError("Email cannot be blank")
            return
        }
        
        guard password != "" else {
            delegate?.registrationError("Cannot register with empty password")
            return
        }
        
        guard password == passwordConfirmation else {
            delegate?.registrationError("Passwords and password confirmation must match")
            return
        }
        
        userService.register(email: email, password: password, fullname: fullname, username: username).then { user -> Void in
            self.delegate?.userRegistered(user)
            self.currentUser = user
        }.catch { error in
            self.delegate?.registrationError(error.localizedDescription)
        }
    }
    
    func logout(){
        userService.logout().then { _ -> Void in
            self.currentUser = nil
            self.delegate?.userLoggedOut()
        }.catch { error in
            self.delegate?.logoutError(error.localizedDescription)
        }
    }
    
    
}
