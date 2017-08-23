//
//  ticket.swift
//  cinego
//
//  Created by Joshua Orozco on 7/24/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

//class Ticket {
//    
//    let ticketNumber: Int?
//    let seatNumber: Int?
//    let price: Double?
//    
//    init(ticketNumber: Int, seatNumber: Int, price: Double = 20.00){
//        self.ticketNumber = ticketNumber
//        self.seatNumber = seatNumber
//        self.price = price
//    }
//    
//}

struct Ticket {
    let id: String
    let price: Double
    let seats: Seat
}
