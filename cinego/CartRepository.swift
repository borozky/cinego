//
//  CartRepository.swift
//  cinego
//
//  Created by Victor Orosco on 16/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol ICartRepository {
    
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
        return CartRepository.cart
    }
    
    func destroyCart() {
        CartRepository.cart = []
    }
    
    func updateCart(_ cartItem: CartItem) -> CartItem? {
        for (key, item) in CartRepository.cart.enumerated() {
            guard item.movieSession.movie.id == cartItem.movieSession.movie.id else {
                continue
            }
            
            guard cartItem.movieSession.id == item.movieSession.id else {
                continue
            }
            
            CartRepository.cart[key] = cartItem
            return cartItem
        }
        // failed to update
        return nil
    }
    
}
