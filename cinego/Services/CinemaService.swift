//
//  CinemaService.swift
//  cinego
//
//  Created by Josh MacDev on 20/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

import PromiseKit
import SwiftyJSON
import Firebase
import Haneke
import CoreData

var CINEMACACHE = [String: Cinema]()

protocol ICinemaService: class {
    func getAllCinemas() -> Promise<[Cinema]>
    func getCinema(byId id: String) -> Promise<Cinema>
}

enum CinemaServiceError : Error {
    case NotFound(String)
    case NoCinemasAvailable(String)
}

class CinemaService : ICinemaService {
    
    let cinemaFirebaseReference = Database.database().reference().child("cinemas")
    
    var cinemaRepository: CinemaCoreDataRepository
    init(cinemaRepository: CinemaCoreDataRepository){
        self.cinemaRepository = cinemaRepository
    }
    
    
    // Loads cinema information
    // This will try to load from cache or load from Firebase if fails
    func getAllCinemas() -> Promise<[Cinema]> {
        
        if Array(CINEMACACHE.keys).count > 0 {
            return Promise(value: Array(CINEMACACHE.values))
        }
        
        return Promise { fulfill, reject in
            cinemaFirebaseReference.observeSingleEvent(of: .value, with: { snapshot in
                
                guard snapshot.hasChildren() else {
                    reject(CinemaServiceError.NoCinemasAvailable("No cinemas available"))
                    return
                }
                
                do {
                    var cinemas: [Cinema] = []
                    for item in snapshot.children.allObjects as! [DataSnapshot] {
                        
                        var json = SwiftyJSON.JSON(item.value!)
                        let id = SwiftyJSON.JSON(item.key)
                        json["id"] = id
                        
                        let cinema = try Cinema(json: json)
                        cinemas.append(cinema)
                        
                    }
                    
                    // save to cache
                    for cinema in cinemas {
                        CINEMACACHE[cinema.id] = cinema
                    }
                    fulfill(cinemas)
                    
                } catch let error {
                    reject(error)
                }
            })
        }
    }
    
    // Gets cinema by ID
    // This will try to load from cache, or loads from Firebase if fails
    func getCinema(byId id: String) -> Promise<Cinema> {
        if let cinemaFromCache = CINEMACACHE[id] {
            return Promise(value: cinemaFromCache)
        }
        
        return getAllCinemas().then { cinemas in
            return Promise { fulfill, reject in
                let cinema = cinemas.first(where: { $0.id == id })
                guard cinema != nil else {
                    reject(CinemaServiceError.NotFound("Cinema not found"))
                    return
                }
                fulfill(cinema!)
            }
        }
    }
    
}
