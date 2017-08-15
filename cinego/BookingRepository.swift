//
//  BookingRepository.swift
//  cinego
//
//  Created by Joshua Orozco on 8/15/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation


protocol IBookingRepository {
    func find(byId id: String) -> Booking?
    func findAll() -> [Booking]
    func findAll(byUser user: User) -> [Booking]
    func findAll(byMovieSession movieSession: MovieSession) -> [Booking]
    func findAll(byMovie movie: Movie) -> [Booking]
    func findAll(byCinema cinema: Cinema) -> [Booking]
    func findAll(from: Date, to: Date?) -> [Booking]
    
    func create(booking: Booking) -> Booking?
    func update(booking: Booking) -> Booking?
    func delete(booking: Booking) -> Bool
}

class BookingRepository: IBookingRepository {

    func find(byId id: String) -> Booking? {
        return nil
    }
    
    func findAll() -> [Booking] {
        return []
    }
    
    func findAll(byUser: User) -> [Booking] {
        return []
    }
    
    func findAll(byMovie: Movie) -> [Booking] {
        return []
    }
    
    func findAll(byCinema cinema: Cinema) -> [Booking] {
        return []
    }
    
    func findAll(from: Date, to: Date? = nil) -> [Booking] {
        return []
    }
    
    func findAll(byMovieSession: MovieSession) -> [Booking] {
        return []
    }
    
    func create(booking: Booking) -> Booking? {
        return nil
    }
    
    func update(booking: Booking) -> Booking? {
        return nil
    }
    
    func delete(booking: Booking) -> Bool {
        return false
    }
    
}
