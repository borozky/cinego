//
//  cinema.swift
//  cinego
//
//  Created by Joshua Orozco on 7/24/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

//class Cinema {
//    
//    let id: Int?
//    let name: String?
//    let numSeats: Int?
//    let address: String?
//    let details: String?
//    var images: [String] = []
//    
//    init(id: Int = 0, name: String, numSeats: Int = 20, address: String = "", details: String = ""){
//        self.name = name
//        self.numSeats = numSeats
//        self.address = address
//        self.details = details
//        self.id = id
//    }
//    
//    
//}

struct Cinema {
    let id: String
    let name: String
    let address: String
    let details: String
    let images: [String]
    let rows: [Character]
    let seatMatrix: [Int]
    var reservedSeats: [Int] = []
    var numSeats: Int {
        get { return seatMatrix.reduce(0) { $0 + ($1 * (rows.count)) } }
    }
    var seatingArrangement: [[Seat]] {
        get {
            var arrangement: [[Seat]] = []
            var currentID = 1
            var startingColumnNumber = 1
            for numOfColumnsInSection in seatMatrix {
                for colNumber in startingColumnNumber..<(startingColumnNumber + numOfColumnsInSection) {
                    var column: [Seat] = []
                    for rowNumber in rows {
                        let isSeatReserved = reservedSeats.filter { $0 == currentID }.count > 0
                        column.append(Seat(id: currentID, rowNumber: rowNumber, colNumber: colNumber, status: isSeatReserved ? .RESERVED : .AVAILABLE))
                        currentID += 1
                    }
                    arrangement.append(column)
                }
                startingColumnNumber += numOfColumnsInSection
            }
            return arrangement
        }
    }
}
