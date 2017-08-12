//
//  cinema.swift
//  cinego
//
//  Created by Joshua Orozco on 7/24/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class Cinema {
    
    let id: Int?
    let name: String?
    let numSeats: Int?
    let address: String?
    let details: String?
    var images: [String] = []
    
    init(id: Int = 0, name: String, numSeats: Int = 20, address: String = "", details: String = ""){
        self.name = name
        self.numSeats = numSeats
        self.address = address
        self.details = details
        self.id = id
    }
    
    
}
