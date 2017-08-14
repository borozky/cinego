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
        var cinemas = [Cinema]()
        
        var cinema = Cinema(id: 1, name: "Melbourne CBD ", numSeats: 20, address: "123 Flinders Street, Melbourne VIC 3000", details: "This is the details of the movie theater")
        cinema.images = ["cinema-melbourne_cbd-1", "cinema-melbourne_cbd-2", "cinema-melbourne_cbd-3", "cinema-melbourne_cbd-4", "cinema-melbourne_cbd-5"]
        cinemas.append(cinema)
        
        cinema = Cinema(id: 2, name: "Fitzroy", numSeats: 30, address: "207 Fitzroy St, Fitzroy VIC 3065", details: "Fitzroy cinema has the most number of seats of all movie theaters")
        cinema.images = ["cinema-fitzroy-1", "cinema-fitzroy-2", "cinema-fitzroy-3", "cinema-fitzroy-4", "cinema-fitzroy-5"]
        cinemas.append(cinema)
        
        cinema = Cinema(id: 3, name: "St. Kilda", numSeats: 25, address: "500 Barkly Street, St. Kilda VIC 3182", details: "...")
        cinema.images = ["cinema-st_kilda-1", "cinema-st_kilda-2", "cinema-st_kilda-3", "cinema-st_kilda-4", "cinema-st_kilda-5"]
        cinemas.append(cinema)
        
        cinema = Cinema(id: 4, name: "Sunshine", numSeats: 25, address: "80  Harvester Road, Sunshine VIC 3020", details: "...")
        cinema.images = ["cinema-sunshine-1", "cinema-sunshine-2", "cinema-sunshine-3", "cinema-sunshine-4", "cinema-sunshine-5"]
        cinemas.append(cinema)
        
        return cinemas
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