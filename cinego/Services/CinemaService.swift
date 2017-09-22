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
    
    func getAllCinemas() -> Promise<[Cinema]> {
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
                    fulfill(cinemas)
                } catch let error {
                    reject(error)
                }
            })
        }
    }
    
    func getCinema(byId id: String) -> Promise<Cinema> {
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
