//
//  BookingSummaryViewModel.swift
//  cinego
//
//  Created by Josh MacDev on 30/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class BookingSummaryViewModel {
    var booking: Booking!
    
    var userService: IUserService
    init(userService: IUserService) {
        self.userService = userService
    }
    
    // Not much going on here
    
}
