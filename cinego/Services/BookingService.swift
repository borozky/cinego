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
    func book(sessionID: String, numTickets: Int, seats: [Seat], price: Double) -> Promise<Booking>
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
    
    // book to movie using the details provided
    func book(sessionID: String, numTickets: Int, seats: [Seat], price: Double) -> Promise<Booking> {
        let seatsStrArray = seats.map { String($0.id) }
        var movieSession: MovieSession!
        
        // book using Firebase
        return movieSessionService.getMovieSession(byId: Int(sessionID)!)
        .then { session -> Promise<FirebaseBooking> in
            movieSession = session
            return self.firebaseBookingService.book(sessionID: sessionID, numTickets: numTickets, seats: seatsStrArray, price: price)
        }
        // then create a Booking object
        .then { firebaseBooking -> Promise<Booking> in
            let booking = Booking(id: firebaseBooking.bookingID, userId: firebaseBooking.user_id, seats: seatsStrArray, movieSession: movieSession)
            return Promise(value: booking)
        }
    }
    
    // Gets users booking
    func getBookings(byUserId userID: String) -> Promise<[Booking]> {
        var firebaseBookings: [FirebaseBooking] = []
        var movieSessions: [MovieSession] = []
        
        // Gets booking from Firebase based on userID
        return firebaseBookingService.getBookings(byUserID: userID)
        
        // loads movie sessions based on users bookings
        .then { bookings in
            firebaseBookings = bookings
            return when(fulfilled: bookings.map {
                let id = Int($0.moviesession_id)!
                return self.movieSessionService.getMovieSession(byId: id)
            })
        }
        .then { sessions -> Void in
            movieSessions = sessions
        }
            
        // create a Promise object that returns booking information
        .then {
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
    
    // Gets all bookings that will happen in the future
    func getBookings(fromNow date: Date, userID: String) -> Promise<[Booking]> {
        return getBookings(byUserId: userID).then {
            return Promise(value: $0.filter { $0.movieSession.startTime > date }.sorted { (bookingA, bookingB) in
                return bookingA.movieSession.startTime > bookingB.movieSession.startTime
            })
        }
    }
    
    // Gets all bookings that have already happened
    func getBookings(untilNow date: Date, userID: String) -> Promise<[Booking]> {
        return getBookings(byUserId: userID).then {
            return Promise(value: $0.filter { $0.movieSession.startTime <= date }.sorted { (bookingA, bookingB) in
                return bookingA.movieSession.startTime > bookingB.movieSession.startTime
            })
        }
    }
}
