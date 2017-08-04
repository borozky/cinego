//
//  Order.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class Order {
    
    private var _id: String = ""
    private var _bookings: [Booking] = []
    private var _totalPrice: Double = 0.0
    private var _gst: Double = 0.0
    private var _shippingPrice: Double = 0.0
    
    private var _address: String?
    private var _telephoneNumber: String?
    private var _email: String?
    
    private var _paymentMethod: String = "paypal"
    
}
