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
    
    static var orders: [Order] = []
    
    func find(byId id: String) -> Order? {
        return OrderRepository.orders.filter { $0.id == id }.first
    }
    
    func findAll(byUser: User) -> [Order] {
        return OrderRepository.orders.filter { $0.userId == byUser.id! }
    }
    
    func findAll(byMovie movie: Movie) -> [Order] {
        return OrderRepository.orders.filter { $0.movieSession.movie.id == movie.id }
    }
    
    func findAll(byMovieSession movieSession: MovieSession) -> [Order] {
        return OrderRepository.orders.filter { $0.movieSession.id == movieSession.id }
    }
    
    func findAll(byCinema cinema: Cinema) -> [Order] {
        return OrderRepository.orders.filter { $0.movieSession.cinema.id == cinema.id }
    }
    
    func findAll(from: Date, to: Date?) -> [Order] {
        return OrderRepository.orders.filter { $0.dateOfPurchase > from && $0.dateOfPurchase < (to ?? Date()) }
    }
    
    func create(order: Order) -> Order? {
        var id = "1"
        
        let lastOrder = OrderRepository.orders.sorted(by: {
            return Int($0.0.id!)! > Int($0.1.id!)!
        }).first
        
        if lastOrder != nil {
            id = String(Int(lastOrder!.id!)! + 1)
        }
        
        OrderRepository.orders.append(Order(id: id, userId: order.userId, seats: order.seats, movieSession: order.movieSession))
        return order
    }
    
    func update(order: Order) -> Order? {
        return nil
    }
    
    func delete(order: Order) -> Bool {
        return false
    }
    
}
