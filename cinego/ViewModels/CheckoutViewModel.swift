//
//  CheckoutViewModel.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol CheckoutViewModelDelegate: class {
    func bookingPlaced(_ booking: Booking) -> Void
    func userLoggedIn(_ user: User) -> Void
    func userLoggedOut() -> Void
}

class CheckoutViewModel {
    
    
    var orderTotal: Double!
    var selectedSeats: [Seat]!
    var movieSession: MovieSession!
    
    var user: User? {
        didSet {
            if self.user != nil {
                delegate?.userLoggedIn(self.user!)
            } else {
                delegate?.userLoggedOut()
            }
        }
    }
    
    var delegate: CheckoutViewModelDelegate?
    
    var ticketCalculationService: ITicketCalculationService
    var userService: IUserService
    init(ticketCalculationService: ITicketCalculationService, userService: IUserService){
        self.ticketCalculationService = ticketCalculationService
        self.userService = userService
    }
    
    func placeBooking() {
        print("Place booking...")
    }
    
    func checkAuth(){
        userService.getCurrentUser().then { user in
            self.user = user
        }.catch { error in
            self.user = nil
        }
    }
}


