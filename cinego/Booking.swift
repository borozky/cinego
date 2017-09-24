//
//  Booking.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

enum PaymentMethod: String {
    case PAYPAL = "Paypal"
    case CREDIT_CARD = "Credit Card"
}

struct Booking {
    static let unitPrice = 20.00
    static let gstRate = 0.10
    static let shippingRate = 0.0
    
    
    let id: String?
    let userId: String
    let unitPrice: Double = 20.00
    let seats: [String]
    let movieSession: MovieSession
    var price: Double {
        return Double(self.seats.count) * Booking.unitPrice
    }
    let createdAt: Date = Date()
    var paymentMethod: PaymentMethod {
        return PaymentMethod.PAYPAL
    }
    var shippingCost: Double {
        return price * Booking.shippingRate
    }
    var gst: Double {
        return price * Booking.gstRate
    }
    var subtotal: Double {
        return price - (shippingCost + gst)
    }
}


