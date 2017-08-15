//
//  OrderRepository.swift
//  cinego
//
//  Created by Joshua Orozco on 8/15/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol IOrderRepository {
    func find(byId id: String) -> Order?
    func findAll(byUser: User) -> [Order]
    func findAll(byMovie movie: Movie) -> [Order]
    func findAll(byMovieSession movieSession: MovieSession) -> [Order]
    func findAll(byCinema cinema: Cinema) -> [Order]
    func findAll(from: Date, to: Date?) -> [Order]
    
    func create(order: Order) -> Order?
    func update(order: Order) -> Order?
    func delete(order: Order) -> Bool
}

class OrderRepository: IOrderRepository {
    
    func find(byId id: String) -> Order? {
        return nil
    }
    
    func findAll(byUser: User) -> [Order] {
        return []
    }
    
    func findAll(byMovie movie: Movie) -> [Order] {
        return []
    }
    
    func findAll(byMovieSession movieSession: MovieSession) -> [Order] {
        return []
    }
    
    func findAll(byCinema cinema: Cinema) -> [Order] {
        return []
    }
    
    func findAll(from: Date, to: Date?) -> [Order] {
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
