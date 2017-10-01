//
//  MockCinemaService.swift
//  cinego
//
//  Created by Josh MacDev on 25/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit
@testable import cinego

class MockCinemaService: ICinemaService {
    var cinemas: [Cinema] = [
        Cinema(id: "1",
               name: "Melbourne CBD ",
               address: "123 Flinders Street, Melbourne VIC 3000",
               details: "This is the details of the movie theater",
               images: ["cinema-melbourne_cbd-1", "cinema-melbourne_cbd-2", "cinema-melbourne_cbd-3", "cinema-melbourne_cbd-4", "cinema-melbourne_cbd-5"],
               rows: ["A", "B", "C", "D"],
               seatMatrix: [3,4,5,5,4,3],
               reservedSeats: [], latitude: 0, longitude: 0),
        
        Cinema(id: "2",
               name: "Fitzroy",
               address: "207 Fitzroy St, Fitzroy VIC 3065",
               details: "Fitzroy cinema has the most number of seats of all movie theaters",
               images: ["cinema-fitzroy-1", "cinema-fitzroy-2", "cinema-fitzroy-3", "cinema-fitzroy-4", "cinema-fitzroy-5"],
               rows: ["A", "B", "C", "D"],
               seatMatrix: [3,4,5,5,4,3],
               reservedSeats: [], latitude: 0, longitude: 0),
        
        Cinema(id: "3",
               name: "St. Kilda",
               address: "500 Barkly Street, St. Kilda VIC 3182",
               details: "...",
               images: ["cinema-st_kilda-1", "cinema-st_kilda-2", "cinema-st_kilda-3", "cinema-st_kilda-4", "cinema-st_kilda-5"],
               rows: ["A", "B", "C", "D"],
               seatMatrix: [3,4,5,5,4,3],
               reservedSeats: [], latitude: 0, longitude: 0),
        
        Cinema(id: "4",
               name: "Sunshine",
               address: "80  Harvester Road, Sunshine VIC 3020",
               details: "...",
               images: ["cinema-sunshine-1", "cinema-sunshine-2", "cinema-sunshine-3", "cinema-sunshine-4", "cinema-sunshine-5"],
               rows: ["A", "B", "C", "D"],
               seatMatrix: [3,4,5,5,4,3],
               reservedSeats: [], latitude: 0, longitude: 0),
        
    ]
    
    func getAllCinemas() -> Promise<[Cinema]> {
        return Promise(value: cinemas)
    }
    
    func getCinema(byId id: String) -> Promise<Cinema> {
        return Promise { fulfill, reject in
            guard let cinema = cinemas.first(where: { $0.id == id }) else {
                reject(MockError.NotFound)
                return
            }
            fulfill(cinema)
        }
    }
    
}
