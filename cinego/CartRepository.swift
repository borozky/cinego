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
    static var cart: [CartItem] = []
    
    func addToCart(cartItem: CartItem) {
        CartRepository.cart.append(cartItem)
    }
    
    func getTotalPrice() -> Double {
        var totalPrice = 0.00
        for cartItem in CartRepository.cart {
            totalPrice += cartItem.calculateTotal()
        }
        return totalPrice
    }
    
    func getAll() -> [CartItem] {
        return CartRepository.cart
    }
    
    func destroyCart() {
        CartRepository.cart = []
    }
    
    func updateCart(_ cartItem: CartItem) -> CartItem? {
        for (key, item) in CartRepository.cart.enumerated() {
            guard item.movie?.id == cartItem.movie?.id else {
                continue
            }
            
            guard cartItem.movieSession?.id == item.movieSession?.id else {
                continue
            }
            
            // update cart item
            CartRepository.cart[key] = cartItem
            return cartItem
        }
        
        // failed to update
        return nil
    }
    
}
