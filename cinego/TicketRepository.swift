//
//  TicketRepository.swift
//  cinego
//
//  Created by Joshua Orozco on 8/15/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol ITicketRepository {
    func find(byTicketId id: String) -> Ticket?
    func findAll(byMovie movie: Movie) -> [Ticket]
    func findAll(byMovieSession movieSession: MovieSession) -> [Ticket]
    func findAll(byCinema cinema: Cinema) -> [Ticket]
    func findAll(byOrder order: Order) -> [Ticket]
    func findAll(byUser user: User) -> [Ticket]
    
    func create(order: Order) -> Order?
    func update(order: Order) -> Order?
    func delete(order: Order) -> Bool
}


class TicketRepository: ITicketRepository {
    
    func find(byTicketId id: String) -> Ticket? {
        return nil
    }
    
    func findAll(byMovie movie: Movie) -> [Ticket] {
        return []
    }
    
    func findAll(byMovieSession movieSession: MovieSession) -> [Ticket] {
        return []
    }
    
    func findAll(byCinema cinema: Cinema) -> [Ticket] {
        return []
    }
    
    func findAll(byOrder order: Order) -> [Ticket] {
        return []
    }
    
    func findAll(byUser user: User) -> [Ticket] {
        return []
    }
    
    func create(order: Order) -> Order? {
        return nil
    }
    
    func update(order: Order) -> Order? {
        return nil
    }
    
    func delete(order: Order) -> Bool {
        return false
    }
    
}
