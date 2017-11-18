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
    func bookingFailed(_ error: Error) -> Void
    func userLoggedIn(_ user: User) -> Void
    func userLoggedOut() -> Void
}

class CheckoutViewModel {
    
    // ViewModel Data
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
    
    // dependencies
    var userService: IUserService
    var bookingService: IBookingService
    init(bookingService: IBookingService, userService: IUserService){
        self.bookingService = bookingService
        self.userService = userService
    }
    
    // Book given these details - session id, selected seats, total price
    func placeBooking() {
        bookingService.book(sessionID: movieSession.id, numTickets: selectedSeats.count, seats: selectedSeats, price: orderTotal)
        .then { booking -> Void in
            self.delegate?.bookingPlaced(booking)
        }.catch { error in
            self.delegate?.bookingFailed(error)
        }
    }
    
    // Check login. Checkout page requires login to place booking
    func checkAuth(){
        userService.getCurrentUser().then { user in
            self.user = user
        }.catch { error in
            self.user = nil
        }
    }
}


