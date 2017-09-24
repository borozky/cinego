//
//  BookingService.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit

protocol IBookingService: class {
    func getBookings(byUserId userID: String) -> Promise<[Booking]>
    func getBookings(fromNow date: Date, userID: String) -> Promise<[Booking]>
    func getBookings(untilNow date: Date, userID: String) -> Promise<[Booking]>
}

class BookingService: IBookingService {
    
    var userService: IUserService
    var firebaseBookingService: IFirebaseBookingService
    var movieSessionService: IMovieSessionService
    init(firebaseBookingService: IFirebaseBookingService, userService: IUserService, movieSessionService: IMovieSessionService){
        self.firebaseBookingService = firebaseBookingService
        self.userService = userService
        self.movieSessionService = movieSessionService
    }
    
    func getBookings(byUserId userID: String) -> Promise<[Booking]> {
        var firebaseBookings: [FirebaseBooking] = []
        var movieSessions: [MovieSession] = []
        return firebaseBookingService.getBookings(byUserID: userID).then { bookings in
            firebaseBookings = bookings
            return when(fulfilled: bookings.map {
                let id = Int($0.moviesession_id)!
                return self.movieSessionService.getMovieSession(byId: id)
            })
        }.then { sessions -> Void in
            movieSessions = sessions
        }.then {
            return Promise { fulfill, reject in
                let bookings = firebaseBookings.map { firebaseBooking -> Booking in
                    let movieSession = movieSessions.filter {
                        $0.id == firebaseBooking.moviesession_id
                    }.first!
                    let seats = firebaseBooking.seats
                    return Booking(id: firebaseBooking.bookingID,
                                   userId: firebaseBooking.user_id,
                                   seats: seats,
                                   movieSession: movieSession)
                }
                fulfill(bookings)
            }
        }
    }
    
    func getBookings(fromNow date: Date, userID: String) -> Promise<[Booking]> {
        return getBookings(byUserId: userID).then {
            return Promise(value: $0.filter { $0.createdAt > date })
        }
    }
    
    func getBookings(untilNow date: Date, userID: String) -> Promise<[Booking]> {
        return getBookings(byUserId: userID).then {
            return Promise(value: $0.filter { $0.createdAt <= date })
        }
    }
}
