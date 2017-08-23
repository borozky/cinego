//
//  CinemaRepository.swift
//  cinego
//
//  Created by Victor Orosco on 12/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol ICinemaRepository {
    func getAllCinemas() -> [Cinema]
    func getCinema(byId id: String) -> Cinema?
    func getCinema(byName name: String) -> Cinema?
    
    func find(byId id: String) -> Cinema?
    func find(byName name: String) -> Cinema?
    func findAll() -> [Cinema]
}


class CinemaRepository : ICinemaRepository {
    
    var cinemas: [Cinema] = [
        Cinema(id: "1",
               name: "Melbourne CBD ",
               address: "123 Flinders Street, Melbourne VIC 3000",
               details: "This is the details of the movie theater",
               images: ["cinema-melbourne_cbd-1", "cinema-melbourne_cbd-2", "cinema-melbourne_cbd-3", "cinema-melbourne_cbd-4", "cinema-melbourne_cbd-5"],
               rows: ["A", "B", "C", "D"],
               seatMatrix: [3,4,5,5,4,3],
               reservedSeats: []),
        
        Cinema(id: "2",
               name: "Fitzroy",
               address: "207 Fitzroy St, Fitzroy VIC 3065",
               details: "Fitzroy cinema has the most number of seats of all movie theaters",
               images: ["cinema-fitzroy-1", "cinema-fitzroy-2", "cinema-fitzroy-3", "cinema-fitzroy-4", "cinema-fitzroy-5"],
               rows: ["A", "B", "C", "D"],
               seatMatrix: [3,4,5,5,4,3],
               reservedSeats: []),
        
        Cinema(id: "3",
               name: "St. Kilda",
               address: "500 Barkly Street, St. Kilda VIC 3182",
               details: "...",
               images: ["cinema-st_kilda-1", "cinema-st_kilda-2", "cinema-st_kilda-3", "cinema-st_kilda-4", "cinema-st_kilda-5"],
               rows: ["A", "B", "C", "D"],
               seatMatrix: [3,4,5,5,4,3],
               reservedSeats: []),
        
        Cinema(id: "4",
               name: "Sunshine",
               address: "80  Harvester Road, Sunshine VIC 3020",
               details: "...",
               images: ["cinema-sunshine-1", "cinema-sunshine-2", "cinema-sunshine-3", "cinema-sunshine-4", "cinema-sunshine-5"],
               rows: ["A", "B", "C", "D"],
               seatMatrix: [3,4,5,5,4,3],
               reservedSeats: [])
        
    ]
    
    
    func find(byId id: String) -> Cinema? {
        return cinemas.filter { $0.id == id }.first ?? nil
    }
    
    
    func find(byName name: String) -> Cinema? {
        return cinemas.filter { $0.name == name }.first ?? nil
    }
    
    
    func findAll() -> [Cinema] {
        return cinemas
    }
    
    
    func getAllCinemas() -> [Cinema] {
        return cinemas
    }
    
    
    func getCinema(byId id: String) -> Cinema? {
        return cinemas.filter { $0.id == id }.first
    }
    
    
    func getCinema(byName name: String) -> Cinema? {
        return cinemas.filter { return $0.name == name }.first
    }
    
}
