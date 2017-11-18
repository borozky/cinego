//
//  MovieSessionService.swift
//  cinego
//
//  Created by Josh MacDev on 21/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON
import Firebase
import Haneke

var MOVIESESSIONCACHE = [String: MovieSession]()

// Getting movie sessions is more complex

// 1. Create a firebase database query (DatabaseQuery)
// 2. Create a promise that retrieves all movie session from firebase based on the DatabaseQuery
// 3. Model each movies session items from firebase using FirebaseMovieSession struct
// 4. FirebaseMovieSession model has movieId and cinemaId field. 
//    Retrieve the full movie and cinema details with IMovieService and ICinemaService
// 5. Use the cinema and movie information to create a collection of MovieSession objects

protocol IMovieSessionService: class {
    func getMovieSessions() -> Promise<[MovieSession]>
    func getMovieSessions(byMovieId movieId: Int) -> Promise<[MovieSession]>
    func getMovieSessions(byCinemaId cinemaId: String) -> Promise<[MovieSession]>
    func getMovieSession(byId id: Int) -> Promise<MovieSession>
//    func getAllUpcomingMovieSessions() -> Promise<[MovieSession]>
}

// The JSON from movie sessions data will have this structure
struct FirebaseMovieSession {
    let id: String
    let dateStr: String
    let movieId: String
    let cinemaId: String
}


enum MovieSessionServiceError: Error {
    case NoMovieSessionsAvailable(String)
    case MovieSessionNotFound(String)
}

class MovieSessionService: IMovieSessionService {
    
    private let formatter = DateFormatter()
    
    var movieService: IMovieService
    var cinemaService: ICinemaService
    var firebaseMovieSessionService: IFirebaseMovieSessionService
    
    init(movieService: IMovieService, cinemaService: ICinemaService, firebaseMovieSessionService: IFirebaseMovieSessionService){
        self.movieService = movieService
        self.cinemaService = cinemaService
        self.firebaseMovieSessionService = firebaseMovieSessionService
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxx"
    }
    
    // TO REDUCE REPEATING CODE, I ARRANGED THE CODE THIS WAY
    // It is a bit coupled to firebase...
    
    func getMovieSessions() -> Promise<[MovieSession]> {
        let promise = firebaseMovieSessionService.getMovieSessions()
        return convertFirebaseMovieSessionPromise(promise)
    }
    
    func getMovieSessions(byMovieId movieId: Int) -> Promise<[MovieSession]> {
        let promise = firebaseMovieSessionService.getMovieSessions(byMovieId: movieId)
        return convertFirebaseMovieSessionPromise(promise)
    }
    
    func getMovieSessions(byCinemaId cinemaId: String) -> Promise<[MovieSession]> {
        let promise = firebaseMovieSessionService.getMovieSessions(byCinemaId: cinemaId)
        return convertFirebaseMovieSessionPromise(promise)
    }
    
    func getMovieSession(byId id: Int) -> Promise<MovieSession> {
        if let movieSessionFromCache = MOVIESESSIONCACHE[String(id)] {
            return Promise(value: movieSessionFromCache)
        }
        
        return firebaseMovieSessionService.getMovieSession(byId: id).then { result in
            return self.convertFirebaseMovieSessionPromise( Promise(value: [result]) )
        }.then { movieSessions in
            return Promise { fulfill, reject in
                let movieSession = movieSessions.first
                guard movieSession != nil else {
                    reject(MovieSessionServiceError.MovieSessionNotFound("Movie session with ID:\(String(id)) cannot be found"))
                    return
                }
                fulfill(movieSession!)
            }
        }
    }
    
    
    // retrieve all cinemas and movies associated with the movie session
    func convertFirebaseMovieSessionPromise(_ firebaseMovieSessionPromise: Promise<[FirebaseMovieSession]>) -> Promise<[MovieSession]> {
        var firebaseMovieSessions: [FirebaseMovieSession] = []
        var cinemas: [Cinema] = []
        var movieIds: Set<Int> = []
        
        // 1. loads sessions from Firebase
        // 2. Get all cinemas and movies
        // 3. Create movie sessions by using the results from 
        //    cinemas and movies retrieved to populate movie and cinema information
        
        return firebaseMovieSessionPromise.then { (results) -> Void in
            firebaseMovieSessions = results
            for item in firebaseMovieSessions {
                movieIds.insert(Int(item.movieId)!)
            }
            }.then {
                self.cinemaService.getAllCinemas()
            }.then { (results) -> Void in
                cinemas = Array(results)
            }.then {
                self.movieService.getAllMovies(byIds: Array(movieIds))
            }.then { movies -> Promise<[MovieSession]> in
                return Promise { fulfill, reject in
                    let movieSessions = firebaseMovieSessions.map { firebaseMovieSession -> MovieSession in
                        let movie = movies.first(where: { $0.id == firebaseMovieSession.movieId })!
                        let cinema = cinemas.first(where: { $0.id == firebaseMovieSession.cinemaId })!
                        let date = self.formatter.date(from: firebaseMovieSession.dateStr)
                        return MovieSession(id: firebaseMovieSession.id, startTime: date!, cinema: cinema, movie: movie)
                    }
                    
                    // cache into MOVIESESSIONCACHE
                    for m in movieSessions {
                        MOVIESESSIONCACHE[m.id] = m
                    }
                    
                    fulfill(movieSessions)
                }
        }
    }
    
}

