//
//  MockFirebaseBookingService.swift
//  cinego
//
//  Created by Josh MacDev on 25/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import Firebase
import PromiseKit
@testable import cinego



class MockFirebaseBookingService: IFirebaseBookingService {
    
    var firebaseUserService: IFirebaseUserService
    init(firebaseUserService: IFirebaseUserService) {
        self.firebaseUserService = firebaseUserService
    }
    
    var bookings: [FirebaseBooking] = [
        FirebaseBooking(bookingID: "123456", moviesession_id: "1", seats: ["A1", "A2"], user_id: "12345", created_at: Date(), price: 40.00)
    ]
    
    func book(sessionID: String, numTickets: Int, seats: [String], price: Double) -> Promise<FirebaseBooking> {
        return firebaseUserService.getCurrentUser().then { user in
            let booking = FirebaseBooking(bookingID: String(123456 + self.bookings.count),
                                          moviesession_id: sessionID,
                                          seats: seats,
                                          user_id: user.uid,
                                          created_at: Date(),
                                          price: price)
            self.bookings.append(booking)
            return Promise(value: booking)
        }
    }
    func getBookings(byUserID userID: String) -> Promise<[FirebaseBooking]> {
        let booking = bookings.filter { $0.user_id == userID }
        guard booking.count > 0 else {
            return Promise(error: MockError.NotFound)
        }
        return Promise(value: booking)
    }
    func getDatabaseReference() -> DatabaseReference {
        return DatabaseReference()
    }
}
