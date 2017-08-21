//
//  CartItem.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class CartItem {
    
    private var unitPrice: Double = 20.00
    private var total: Double = 0.0
    
    public var movie: Movie?
    public var movieSession: MovieSession?
    public var numTickets: Int = 0
    public var seatNumbers: [Int] = []
    public var seats: [Seat] = []
    
    
    public init(movie: Movie,
                movieSession: MovieSession,
                numTickets: Int = 0,
                seatNumbers: [Int] = [],
                seats: [Seat] = []){
        self.movie = movie
        self.movieSession = movieSession
        self.numTickets = numTickets
        self.seatNumbers = seatNumbers
        self.seats = seats
        
    }
    
    public func calculateTotal() -> Double {
        return Double(numTickets) * unitPrice
    }
    
    
    
    
    
}
