//
//  cinema.swift
//  cinego
//
//  Created by Joshua Orozco on 7/24/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//
import Foundation
import SwiftyJSON

struct Cinema {
    let id: String
    let name: String
    let address: String
    let details: String
    let images: [String]
    let rows: [Character]
    let seatMatrix: [Int]
    var reservedSeats: [Int] = []
    
    
    // Flinders Street
    var latitude: Double = -37.81719612327876
    var longitude: Double =  144.96831983327866
    
    
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

extension Cinema {
    init(json: JSON) throws {
        let id = String(describing: json["id"])
        let name = String(describing: json["name"])
        let address = String(describing: json["address"])
        let details = json["details"].stringValue
        let images: [String] = []
        let rows: [Character] = ["a", "b", "c", "d"]
        let seatMatrix: [Int] = [4, 5, 5, 4]
        let reservedSeats: [Int] = []
        let latitude = json["latitude"].doubleValue
        let longitude = json["longitude"].doubleValue
        
        
        self.init(id: id,
                  name: name,
                  address: address,
                  details: details,
                  images: images,
                  rows: rows,
                  seatMatrix: seatMatrix,
                  reservedSeats: reservedSeats,
                  latitude: latitude,
                  longitude: longitude)
        
    }
    
    init(cinemaEntity: CinemaEntity) throws {
        let id = cinemaEntity.firebaseId!
        let name = cinemaEntity.name!
        let address = cinemaEntity.location!
        let details = cinemaEntity.details!
        let images: [String] = []
        let rows: [Character] = ["a", "b", "c", "d"]
        let seatMatrix: [Int] = [4, 5, 5, 4]
        let reservedSeats: [Int] = []
        let latitude = cinemaEntity.latitude
        let longitude = cinemaEntity.longitude
        
        self.init(id: id,
                  name: name,
                  address: address,
                  details: details,
                  images: images,
                  rows: rows,
                  seatMatrix: seatMatrix,
                  reservedSeats: reservedSeats,
                  latitude: latitude,
                  longitude: longitude)
    }
}

