//
//  Seat.swift
//  cinego
//
//  Created by Victor Orosco on 19/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

enum SeatStatus {
    case AVAILABLE, SELECTED, RESERVED
}

struct Seat {
    static let defaultSize = 32
    
    let id: Int
    let rowNumber: Character
    let colNumber: Int
    var status: SeatStatus = .AVAILABLE
}
