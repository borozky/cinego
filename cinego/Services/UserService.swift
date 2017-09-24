//
//  UserService.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit

/*
 struct Order {
     static let pricePerTicket = 20.00
     static let gstRate: Double = 0.10
     static let shippingRate: Double = 0.00
     
     let dateOfPurchase: Date = Date()
     
     var gst: Double {
        get { return Order.gstRate * totalPrice }
     }
     var shippingCost: Double {
        get { return Order.shippingRate * totalPrice }
     }
     var totalPrice: Double {
        return Double(numTickets) * Order.pricePerTicket
     }
     var subtotal: Double {
        return totalPrice * (1.0 - Order.gstRate)
     }
     var numTickets: Int {
        return seats.count
     }
     
     let id: String?
     let userId: String
     let seats: [Seat]
     let movieSession: MovieSession
     let paymentMethod: PaymentMethod = .PAYPAL
 
 }
 
 struct User {
     let id: String?
     let username: String
     let email: String
     let fullname: String
     let password: String
     var orders: [Order] = []
     var userType: UserTypes {
         return id == nil ? .GUEST : .REGISTERED
     }
 }
 
 */
import FirebaseAuth

protocol IUserService {
    func login(email: String, password: String) -> Promise<User>
    func register(email: String, password: String, fullname: String, username: String) -> Promise<User>
    func logout() -> Promise<Void>
    func getCurrentUser() -> Promise<User>
//    func addDetails(key: String, value: Any) -> Promise<(String, Any)>
//    func updateDetails(key: String, value: Any) -> Promise<Any>
}

enum UserServiceError: Error {
    case ValidationError(String)
}

class UserService: IUserService {
    
    var firebaseUserService: IFirebaseUserService
    init(firebaseUserService: IFirebaseUserService){
        self.firebaseUserService = firebaseUserService
    }
    
    func getCurrentUser() -> Promise<User> {
        return when(fulfilled:
            firebaseUserService.getCurrentUser(),
            firebaseUserService.getProfileDetails()
        ).then { firebaseUser, details in
            let email = firebaseUser.email!
            let id = firebaseUser.uid
            let fullname = String(describing: details["fullname"])
            let username = String(describing: details["username"])
            let user = User(id: id, username: username, email: email, fullname: fullname, password: "", bookings: [])
            return Promise(value: user)
        }
    }
    
    func login(email: String, password: String) -> Promise<User> {
        return firebaseUserService.login(email: email, password: password)
        .then {
            when(fulfilled: Promise(value: $0), self.firebaseUserService.getProfileDetails())
        }.then { firebaseUser, details in
            let userID = firebaseUser.uid
            let email = firebaseUser.email!
            let fullname = String(describing: details["fullname"])
            let username = String(describing: details["username"])
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
    
    func register(email: String, password: String, fullname: String, username: String) -> Promise<User> {
        guard email.characters.count > 0 else {
            return Promise(error: UserServiceError.ValidationError("Email is required"))
        }
        guard password.characters.count >= 6 else {
            return Promise(error: UserServiceError.ValidationError("Password should be at least 6 characters"))
        }
        guard fullname.characters.count > 1 else {
            return Promise(error: UserServiceError.ValidationError("Fullname should be at least 1 character"))
        }
        guard username.characters.count >= 6 else {
            return Promise(error: UserServiceError.ValidationError("Username must be at least 6 characters"))
        }
        guard username.characters.count >= 6 else {
            return Promise(error: UserServiceError.ValidationError("Username must be at least 6 characters"))
        }
        guard validateEmail(candidate: email) else {
            return Promise(error: UserServiceError.ValidationError("\(email) is not a valid email"))
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
    
    func logout() -> Promise<Void> {
        return firebaseUserService.logout()
    }
    
    // FROM http://emailregex.com/
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
}









