//
//  CartRepository.swift
//  cinego
//
//  Created by Victor Orosco on 16/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol ICartRepository {
    
    func findCartItem(byMovieSession movieSession: MovieSession) -> CartItem?
    func findAllCartItems(byMovie movie: Movie) -> [CartItem]
    func addToCart(cartItem: CartItem)
    func getTotalPrice() -> Double
    func getAll() -> [CartItem]
    func updateCart(_ cartItem: CartItem) -> CartItem?
    func destroyCart()
}

class CartRepository: ICartRepository {
    
    // singleton
    static var cart: [CartItem] = []
    
    func addToCart(cartItem: CartItem) {
        CartRepository.cart.append(cartItem)
    }
    
    func getTotalPrice() -> Double {
        return CartRepository.cart.reduce(0.0) { $0 + $1.totalPrice }
    }
    
    func getAll() -> [CartItem] {
        return CartRepository.cart.sorted(by: { itemA, itemB -> Bool in
            return itemA.added < itemB.added
        })
    }
    
    func destroyCart() {
        CartRepository.cart = []
    }
    
    func updateCart(_ cartItem: CartItem) -> CartItem? {
        
        for (key, item) in CartRepository.cart.enumerated() {
            guard item.movieSession.id == cartItem.movieSession.id else {
                continue
            }
            
            CartRepository.cart[key].seats = cartItem.seats
            return cartItem
        }
        // failed to update
        return nil
    }
    
    func findCartItem(byMovieSession movieSession: MovieSession) -> CartItem? {
        return CartRepository.cart.filter { $0.movieSession.id == movieSession.id }.first ?? nil
    }
    
    func findAllCartItems(byMovie movie: Movie) -> [CartItem] {
        return CartRepository.cart.filter { $0.movieSession.movie.id == movie.id }
    }
    
}