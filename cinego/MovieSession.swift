//
//  session.swift
//  cinego
//
//  Created by Joshua Orozco on 7/24/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation


class MovieSession {
    
    let id: Int?
    let startTime: String?
    let cinema: Cinema?
    let movieId: Int?
    
    var tickets: [Ticket] = []
    
    init(id: Int, startTime: String = "1 January, 1970 00:00:00am", cinema: Cinema, movieId: Int = 0) {
        self.id = id
        self.startTime = startTime
        self.cinema = cinema
        self.movieId = movieId
    }
    
    func addTicket(_ ticket: Ticket) {
        tickets.append(ticket)
    }
    
    
    
}
