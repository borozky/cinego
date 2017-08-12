//
//  CinemaRepository.swift
//  cinego
//
//  Created by Victor Orosco on 12/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class CinemaRepository : ICinemaRepository {
    
    func getAllCinemas() -> [Cinema] {
        return [
            Cinema(id: 1,
                   name: "Melbourne CBD ",
                   numSeats: 20,
                   address: "123 Flinders Street, Melbourne VIC 3000",
                   details: "This is the details of the movie theater"),
            
            Cinema(id: 2,
                   name: "Fitzroy",
                   numSeats: 30,
                   address: "207 Fitzroy St, Fitzroy VIC 3065",
                   details: "Fitzroy cinema has the most number of seats of all movie theaters"),
            
            Cinema(id: 3,
                   name: "St. Kilda",
                   numSeats: 25,
                   address: "500 Barkly Street, St. Kilda VIC 3182",
                   details: "..."),
            
            Cinema(id: 4,
                   name: "Sunshine",
                   numSeats: 25,
                   address: "80  Harvester Road, Sunshine VIC 3020",
                   details: "...")
        ]
    }
    
    
    func getCinema(byId id: Int) -> Cinema? {
        let cinemas = getAllCinemas()
        for cinema in cinemas {
            if cinema.id == id {
                return cinema
            }
        }
        return nil
    }
    
    
    func getCinema(byName name: String) -> Cinema? {
        let cinemas = getAllCinemas()
        for cinema in cinemas {
            if cinema.name == name {
                return cinema
            }
        }
        return nil
    }
    
}
