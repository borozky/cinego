//
//  MockFirebaseMovieSessionService.swift
//  cinego
//
//  Created by Josh MacDev on 25/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import Firebase
import PromiseKit
@testable import cinego

/*
 
 func getMovieSessions() -> Promise<[FirebaseMovieSession]>
 func getMovieSessions(byMovieId movieId: Int) -> Promise<[FirebaseMovieSession]>
 func getMovieSessions(byCinemaId cinemaId: String)  -> Promise<[FirebaseMovieSession]>
 func getMovieSession(byId id: Int) -> Promise<FirebaseMovieSession>
 func createMovieSessionPromise() -> Promise<[FirebaseMovieSession]>
 func createMovieSessionPromise(_ firebaseDatabaseQuery: DatabaseQuery) -> Promise<[FirebaseMovieSession]>*/

class MockFirebaseMovieSessionService: IFirebaseMovieSessionService {
    var sessions = [
        FirebaseMovieSession(id: "1", dateStr: "2016-04-25T23:50:00+10:00", movieId: "1", cinemaId: "1"),
        FirebaseMovieSession(id: "2", dateStr: "2016-04-25T23:50:00+10:00", movieId: "2", cinemaId: "1")
    ]
    
    func getMovieSessions() -> Promise<[FirebaseMovieSession]> {
        return Promise(value: sessions)
    }
    
    func getMovieSessions(byMovieId movieId: Int) -> Promise<[FirebaseMovieSession]> {
        return Promise { fulfill, reject in
            let filtered = sessions.filter { $0.movieId == String(movieId) }
            guard filtered.count > 0 else {
                reject(MockError.NotFound)
                return
            }
            fulfill(filtered)
        }
    }
    func getMovieSessions(byCinemaId cinemaId: String)  -> Promise<[FirebaseMovieSession]> {
        return Promise { fulfill, reject in
            let filtered = sessions.filter { $0.cinemaId == String(cinemaId) }
            guard filtered.count > 0 else {
                reject(MockError.NotFound)
                return
            }
            fulfill(filtered)
        }
    }
    func getMovieSession(byId id: Int) -> Promise<FirebaseMovieSession> {
        return Promise { fulfill, reject in
            let filtered = sessions.filter { $0.id == String(id) }
            guard filtered.count > 0 else {
                reject(MockError.NotFound)
                return
            }
            fulfill(filtered.first!)
        }
    }
    func createMovieSessionPromise() -> Promise<[FirebaseMovieSession]> {
        return getMovieSessions()
    }
    func createMovieSessionPromise(_ firebaseDatabaseQuery: DatabaseQuery) -> Promise<[FirebaseMovieSession]> {
        return getMovieSessions()
    }
    func getDatabaseReference() -> DatabaseReference {
        return DatabaseReference()
    }
}
