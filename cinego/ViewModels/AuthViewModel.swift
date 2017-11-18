//
//  LoginViewModel.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import Firebase
import PromiseKit

protocol AuthViewModelDelegate: class {
    func userLoggedIn(_ user: User) -> Void
    func userRegistered(_ user: User) -> Void
    func userLoggedOut() -> Void
    func loginError(_ message: String) -> Void
    func registrationError(_ message: String) -> Void
    func logoutError(_ message: String) -> Void
}

class AuthViewModel {
    static var isSigninUp = false
    
    weak var delegate: AuthViewModelDelegate?
    var currentUser: User?
    
    var userService: IUserService
    init(userService: IUserService){
        self.userService = userService
    }
    
    // Checks login.
    func checkAuth() {
        userService.getCurrentUser().then {
            self.currentUser = $0
        }.always {}
    }
    
    // Login with email and password. 
    // On successful login, userLoggedIn() method is called, 
    // ... or the loginError() is called otherwise
    func login(_ email: String, _ password: String){
        userService.login(email: email, password: password).then { user -> Void in
            self.currentUser = user
            self.delegate?.userLoggedIn(user)
        }.catch { error -> Void in
            self.delegate?.loginError(error.localizedDescription)
        }
    }
    
    // Register with credentials. Validation is done early
    // When regitrations fails, it will call the delegate to tell what errors were produced
    // Usually, the delegate (ie. RegisterVC) will show an alert message
    // On successful registration, user is AUTOMATICALLY LOGGED IN and it will either
    //      - Go to account page
    //      - Go back to checkout page, when checking out
    func register(email: String, password: String, passwordConfirmation: String, username: String, fullname: String){
        guard fullname != "" else {
            delegate?.registrationError("Fullname cannot be blank")
            return
        }
        
        guard email != "" else {
            delegate?.registrationError("Email cannot be blank")
            return
        }
        
        guard username != "" else {
            delegate?.registrationError("Username cannot be blank")
            return
        }
        
        guard password != "" else {
            delegate?.registrationError("Cannot register with empty password")
            return
        }
        
        guard password == passwordConfirmation else {
            delegate?.registrationError("Passwords and password confirmation doesn't match")
            return
        }
        
        userService.register(email: email, password: password, fullname: fullname, username: username).then { user -> Void in
            self.delegate?.userRegistered(user)
        }.catch { error in
            if let validationError = error as? ValidationError {
                self.delegate?.registrationError(validationError.localizedDescription)
            } else {
                self.delegate?.registrationError(error.localizedDescription)
            }
        }
    }
    
    // Logout
    // The delegate VC will perform segue going back to login page
    func logout(){
        userService.logout().then { _ -> Void in
            self.currentUser = nil
            self.delegate?.userLoggedOut()
        }.catch { error in
            self.delegate?.logoutError(error.localizedDescription)
        }
    }
    
    
}
