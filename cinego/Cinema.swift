//
//  cinema.swift
//  cinego
//
//  Created by Joshua Orozco on 7/24/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation


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
    
    func numberOfSeatsOfType(_ seatType: SeatStatus) -> Int {
        var total = 0
        for col in seatingArrangement {
            total += col.reduce(0){ $0.1.status == seatType ? 1 : 0 }
        }
        return total
    }
}
