//
//  Booking.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class Booking {
    
    public let number: String
    
    private var totalPrice: Double = 0.0
    private var unitPrice: Double = 20.00
    
    public var movie: Movie?
    public var movieSession: MovieSession?
    public var numTickets: Int = 0
    public var seatNumbers: [Int] = []
    public var seats: [Seat] = []
    
    
    public init(movie: Movie, movieSession: MovieSession, numTickets: Int = 0, seatNumbers: [Int] = [], number: String = ""){
        self.movie = movie
        self.movieSession = movieSession
        self.numTickets = numTickets
        self.seatNumbers = seatNumbers
        self.number = number
    }
    
    public func calculateTotalPrice() -> Double {
        return Double(numTickets) * unitPrice
    }
    
}
