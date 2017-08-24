//
//  User.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation


enum UserTypes {
    case GUEST, REGISTERED
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
