//
//  User.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class User {
    
    public let id: String
    public let username: String
    public let email: String
    
    public var orders: [Order]
    
    public init(id: String = "", email: String = "", username: String = "", orders: [Order] = []){
        self.id = ""
        self.username = username
        self.email = email
        self.orders = orders
    }
    
}
