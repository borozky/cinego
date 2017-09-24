//
//  AccountViewModel.swift
//  cinego
//
//  Created by Josh MacDev on 24/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol AccountViewModelDelegate: class {
    func userInformationLoaded(_ user: User) -> Void
    func upcomingBookingsLoaded(_ bookings: [Booking]) -> Void
    func pastBookingsLoaded(_ bookings: [Booking]) -> Void
    func loggedOut() -> Void
    func errorProduced(_ error: Error) -> Void
    func userInformationNotLoaded(_ error: Error) -> Void
    func bookingsNotLoaded(_ error: Error) -> Void
}

class AccountViewModel {
    
    var user: User! {
        didSet {
            if let user = self.user {
                delegate?.userInformationLoaded(user)
            } else {
                delegate?.loggedOut()
            }
        }
    }
    var upcomingBookings: [Booking] = [] {
        didSet { delegate?.upcomingBookingsLoaded(self.upcomingBookings) }
    }
    var pastBookings: [Booking] = [] {
        didSet { delegate?.pastBookingsLoaded(self.pastBookings) }
    }
    
    weak var delegate: AccountViewModelDelegate?
    var userService: IUserService
    var bookingService: IBookingService
    init(bookingService: IBookingService, userService: IUserService){
        self.bookingService = bookingService
        self.userService = userService
    }
    
    func loadUserInformation() {
        userService.getCurrentUser().then { user -> Void in
            self.user = user
        }.catch { error in
            self.delegate?.userInformationNotLoaded(error)
        }
    }
    
    func loadUserBookings(byUserID userID: String) {
        self.bookingService.getBookings(byUserId: userID).then { bookings -> Void in
            self.pastBookings = bookings.filter { $0.createdAt <= Date() }
            self.upcomingBookings = bookings.filter { $0.createdAt > Date() }
        }.catch { error in
            self.delegate?.bookingsNotLoaded(error)
        }
    }
    
    func logout() {
        userService.logout().then {
            self.user = nil
        }.always {}
    }
    
}
