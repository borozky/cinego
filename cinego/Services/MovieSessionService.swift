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
    
    var movieService: IMovieService
    var cinemaService: ICinemaService
    let movieSessionFirebaseReference = Database.database().reference().child("movieSessions")
    
    private let formatter = DateFormatter()
    
    init(movieService: IMovieService, cinemaService: ICinemaService){
        self.movieService = movieService
        self.cinemaService = cinemaService
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxx"
    }
    
    func getMovieSessions() -> Promise<[MovieSession]> {
        return createMovieSessionPromise()
    }
    
    func getMovieSessions(byMovieId movieId: Int) -> Promise<[MovieSession]> {
        let queryByMovieID = self.movieSessionFirebaseReference.queryOrdered(byChild: "themoviedborg_id").queryEqual(toValue: movieId)
        return createMovieSessionPromise(queryByMovieID)
    }
    
    func getMovieSessions(byCinemaId cinemaId: String)  -> Promise<[MovieSession]> {
        let queryCinemaID = self.movieSessionFirebaseReference.queryOrdered(byChild: "cinema_id").queryEqual(toValue: cinemaId)
        return createMovieSessionPromise(queryCinemaID)
    }
    
    
    func getMovieSession(byId id: Int) -> Promise<MovieSession> {
        let queryMovieSession = self.movieSessionFirebaseReference.queryOrdered(byChild: "session_id").queryEqual(toValue: id)
        return createMovieSessionPromise(queryMovieSession).then { movieSessions in
            return Promise { fulfill, reject in
                let movieSession = movieSessions.first
                guard movieSession != nil else {
                    reject(MovieSessionServiceError.MovieSessionNotFound("Movie session cannot be found"))
                    return
                }
                fulfill(movieSession!)
            }
        }
    }
    
    
    // MARK: Helper Methods
    
    func createMovieSessionPromise() -> Promise<[MovieSession]> {
        let promise = createFirebaseMovieSessionPromise()
        return convertFirebaseMovieSessionPromise(promise)
    }
    func createMovieSessionPromise(_ firebaseDatabaseQuery: DatabaseQuery) -> Promise<[MovieSession]> {
        let promise = self.createFirebaseMovieSessionPromise(firebaseDatabaseQuery)
        return convertFirebaseMovieSessionPromise(promise)
    }
    
    
    
    func createFirebaseMovieSessionPromise() -> Promise<[FirebaseMovieSession]> {
        return Promise { fulfill, reject in
            self.movieSessionFirebaseReference.observeSingleEvent(of: .value, with: { snapshot in
                guard snapshot.hasChildren() else {
                    reject(MovieSessionServiceError.NoMovieSessionsAvailable("No sessions available"))
                    return
                }
                
                let firebaseMovieSessions = self.convertSnapshot(toFirebaseMovieSessions: snapshot)
                fulfill(firebaseMovieSessions)
            })
        }
    }
    func createFirebaseMovieSessionPromise(_ firebaseDatabaseQuery: DatabaseQuery) -> Promise<[FirebaseMovieSession]> {
        return Promise { fulfill, reject in
            firebaseDatabaseQuery.observeSingleEvent(of: .value, with: { snapshot in
                print("NUMRESULTS", snapshot.childrenCount)
                guard snapshot.hasChildren() else {
                    reject(MovieSessionServiceError.NoMovieSessionsAvailable("No sessions available"))
                    return
                }
                
                let firebaseMovieSessions = self.convertSnapshot(toFirebaseMovieSessions: snapshot)
                fulfill(firebaseMovieSessions)
            })
        }
    }
    

    
    // retrieve all cinemas and movies associated with the movie session
    func convertFirebaseMovieSessionPromise(_ firebaseMovieSessionPromise: Promise<[FirebaseMovieSession]>) -> Promise<[MovieSession]> {
        var firebaseMovieSessions: [FirebaseMovieSession] = []
        var cinemas: [Cinema] = []
        var movieIds: Set<Int> = []
        
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
                    fulfill(movieSessions)
                }
            }
    }
    
    // helper method
    // Converts Firebase movie session snapshot into array of FirebaseMovieSession objects
    func convertSnapshot(toFirebaseMovieSessions snapshot: DataSnapshot) -> [FirebaseMovieSession] {
        var firebaseMovieSessions: [FirebaseMovieSession] = []
        for item in snapshot.children.allObjects as! [DataSnapshot] {
            let val = item.value as? [String: Any] ?? [:]
            let session_id = String(describing: val["session_id"]!)
            let dateStr = String(describing: val["starttime"]!)
            let movieId = String(describing: val["themoviedborg_id"]!)
            let cinemaId = String(describing: val["cinema_id"]!)
            
            let firebaseMovieSession = FirebaseMovieSession(id: session_id, dateStr: dateStr, movieId: movieId, cinemaId: cinemaId)
            firebaseMovieSessions.append(firebaseMovieSession)
        }
        return firebaseMovieSessions
    }
    
}
