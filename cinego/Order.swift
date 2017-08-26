//
//  Order.swift
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

struct Order {
    let pricePerTicket = 20.00
    let gstRate: Double = 0.10
    let shippingRate: Double = 0.00
    let dateOfPurchase: Date = Date()
    
    var gst: Double {
        get { return gstRate * totalPrice }
    }
    var shippingCost: Double {
        get { return shippingRate * totalPrice }
    }
    var totalPrice: Double {
        return Double(numTickets) * pricePerTicket
    }
    var subtotal: Double {
        return totalPrice * (1.0 - gstRate)
    }
    var numTickets: Int {
        return seats.count
    }
    
    let id: String?
    let userId: String
    let seats: [Seat]
    let movieSession: MovieSession
    let paymentMethod: PaymentMethod = .PAYPAL
    
}
