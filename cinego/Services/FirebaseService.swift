//
//  FirebaseService.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import PromiseKit
import SwiftyJSON

struct FirebaseMovie {
    let id: String
    let tmdb_title: String
    let tmdb_id: String
}

struct FirebaseCinema {
    let id: String
    let address: String
    let images: String
    let name: String
    let seatingArrangement: String
}

struct FirebaseBooking {
    let bookingID: String
    let moviesession_id: String
    let seats: [String]
    let user_id: String
    let created_at: Date
    let price: Double
}
struct FirebaseUser {
    let uid: String
    let email: String?
}

struct FirebaseUserDetails {
    let fullname: String
}

enum FirebaseServiceError: Error {
    case Unauthorized(String)
    case NotFound(String)
}

//enum CinemaServiceError : Error {
//    case NotFound(String)
//    case NoCinemasAvailable(String)
//}

protocol IFirebaseService: class {
    func getDatabaseReference() -> DatabaseReference
}

protocol IFirebaseMovieService: IFirebaseService {
    func getAllFirebaseMovies() -> Promise<[FirebaseMovie]>
}

protocol IFirebaseCinemaService: IFirebaseService {
    //func getAllFirebaseCinemas() -> Promise<[FirebaseCinema]>
}

protocol IFirebaseUserService: IFirebaseService {
    func login(email: String, password: String) -> Promise<FirebaseUser>
    func logout() -> Promise<Void>
    func register(email: String, password: String) -> Promise<FirebaseUser>
    func addUserDetail(key: String, value: Any) -> Promise<(String, Any)>
    func getProfileDetails() -> Promise<[String: Any?]>
    func getCurrentUser() -> Promise<FirebaseUser>
}

protocol IFirebaseBookingService: IFirebaseService {
    func book(sessionID: String, numTickets: Int, seats: [String], price: Double) -> Promise<FirebaseBooking>
    func getBookings(byUserID userID: String) -> Promise<[FirebaseBooking]>
}

protocol IFirebaseMovieSessionService: IFirebaseService {
    func getMovieSessions() -> Promise<[FirebaseMovieSession]>
    func getMovieSessions(byMovieId movieId: Int) -> Promise<[FirebaseMovieSession]>
    func getMovieSessions(byCinemaId cinemaId: String)  -> Promise<[FirebaseMovieSession]>
    func getMovieSession(byId id: Int) -> Promise<FirebaseMovieSession>
    func createMovieSessionPromise() -> Promise<[FirebaseMovieSession]>
    func createMovieSessionPromise(_ firebaseDatabaseQuery: DatabaseQuery) -> Promise<[FirebaseMovieSession]>
}

class FirebaseService {
    let firebaseDatabaseReference = Database.database().reference()
    
    var movieReference: DatabaseReference {
        return firebaseDatabaseReference.child("movies")
    }
    var cinemaReference: DatabaseReference {
        return firebaseDatabaseReference.child("cinemas")
    }
    var movieSessionReference: DatabaseReference {
        return firebaseDatabaseReference.child("movieSessions")
    }
    var userReference: DatabaseReference {
        return firebaseDatabaseReference.child("users")
    }
    var bookingReference: DatabaseReference {
        return firebaseDatabaseReference.child("bookings")
    }
    func getDatabaseReference() -> DatabaseReference {
        return firebaseDatabaseReference
    }
}

extension FirebaseService: IFirebaseBookingService {
    func book(sessionID: String, numTickets: Int, seats: [String], price: Double) -> Promise<FirebaseBooking> {
        return Promise { fulfill, reject in
            guard let currentUser = Auth.auth().currentUser else {
                reject(FirebaseServiceError.Unauthorized("Unauthorized user"))
                return
            }
            
            let userID = currentUser.uid
            let childRef = bookingReference.childByAutoId()
            let date = Date()
            let values: [String: Any] = [
                "user_id" : userID,
                "created_at": date.timeIntervalSince1970,
                "price" : price,
                "seats": seats.joined(separator: ","),
                "session_id": sessionID
            ]
            childRef.updateChildValues(values) { error, reference in
                if error != nil {
                    reject(error!)
                    return
                }
                
                let firebaseBooking = FirebaseBooking(
                    bookingID: childRef.key,
                    moviesession_id: sessionID,
                    seats: seats,
                    user_id: userID,
                    created_at: date,
                    price: price
                )
                fulfill(firebaseBooking)
                
            }
            
        }
    }
    
    func getBookings(byUserID userID: String) -> Promise<[FirebaseBooking]> {
        return Promise { fulfill, reject in
            guard Auth.auth().currentUser?.uid == userID else {
                reject(FirebaseServiceError.Unauthorized("Unauthorized user"))
                return
            }
            
            let queryBookingsByUser = bookingReference.queryOrdered(byChild: "user_id").queryEqual(toValue: userID)
            queryBookingsByUser.observeSingleEvent(of: .value, with: { snapshot in
                var firebaseBookings: [FirebaseBooking] = []
                for child in snapshot.children.allObjects {
                    let item = child as! DataSnapshot
                    let value = item.value as? [String: Any] ?? [:]
                    
                    let bookingID = item.key
                    let session_id = String(describing: value["moviesession_id"]!)
                    let price = value["price"] as! Double
                    let date = Date(timeIntervalSince1970: value["created_at"] as! Double)
                    let userID = String(describing: value["user_id"])
                    let seats = (String(describing: value["seats"])).characters.split{ $0 == ","}.map(String.init)
                    
                    let firebaseBooking = FirebaseBooking(
                        bookingID: bookingID,
                        moviesession_id: session_id,
                        seats: seats,
                        user_id: userID,
                        created_at: date,
                        price: price
                    )
                    firebaseBookings.append(firebaseBooking)
                }
                fulfill(firebaseBookings)
            })
            
            
            
        }
    }
}

extension FirebaseService: IFirebaseUserService {
    
    func login(email: String, password: String) -> Promise<FirebaseUser> {
        
        return Promise { fulfill, reject in
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                guard user != nil else {
                    reject(error!)
                    return
                }
                let firebaseUser = FirebaseUser(uid: user!.uid, email: user!.email)
                fulfill(firebaseUser)
            }
        }
    }
    
    
    func logout() -> Promise<Void> {
        return Promise { fulfill, reject in
            do {
                try Auth.auth().signOut()
                fulfill()
            } catch let error {
                reject(error)
            }
            
        }
    }
    
    
    func addUserDetail(key: String, value: Any) -> Promise<(String, Any)> {
        return Promise { fulfill, reject in
            guard let currentUser = Auth.auth().currentUser else {
                reject(FirebaseServiceError.Unauthorized("Unauthorized user"))
                return
            }
            
            // TODO: Some sanitation goes here
            
            let userID = currentUser.uid
            let userDetailsReference = self.userReference.child(userID)
            let values = [key: value]
            userDetailsReference.updateChildValues(values) { error, reference in
                guard error == nil else {
                    reject(error!)
                    return
                }
                
                fulfill(key, value)
            }
            
        }
    }
    
    
    func getProfileDetails() -> Promise<[String: Any?]> {
        return Promise { fulfill, reject in
            guard let currentUser = Auth.auth().currentUser else {
                reject(FirebaseServiceError.Unauthorized("Unauthorized user"))
                return
            }
            let userID = currentUser.uid
            let userDetailsReference = self.userReference.child(userID)
            userDetailsReference.observeSingleEvent(of: .value, with: { snapshot in
                let value = snapshot.value as? [String: Any?] ?? [:]
                fulfill(value)
            })
            
            
        }
    }
    
    func getCurrentUser() -> Promise<FirebaseUser> {
        return Promise { fulfill, reject in
            guard let currentUser = Auth.auth().currentUser else {
                reject(FirebaseServiceError.Unauthorized("User not logged in"))
                return
            }
            
            let firebaseUser = FirebaseUser(uid: currentUser.uid, email: currentUser.email)
            fulfill(firebaseUser)
        }
    }
    
    
    func getUserDetail(key: String) -> Promise<Any>{
        return Promise { fulfill, reject in
            guard let currentUser = Auth.auth().currentUser else {
                reject(FirebaseServiceError.Unauthorized("Unauthorized user"))
                return
            }
            
            let userID = currentUser.uid
            let userDetailsReference = self.userReference.child(userID)
            guard let detail = userDetailsReference.value(forKey: key) else {
                reject(FirebaseServiceError.NotFound("User details with key: \(key) cannot be found"))
                return
            }
            
            fulfill(detail)
        }
    }
    
    
    func register(email: String, password: String) -> Promise<FirebaseUser> {
        return Promise { fulfill, reject in
            
            // TODO: Validation rules
            
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                guard user != nil else {
                    reject(error!)
                    return
                }
                let firebaseUser = FirebaseUser(uid: user!.uid, email: user!.email)
                fulfill(firebaseUser)
            }
        }
    }
}

extension FirebaseService: IFirebaseMovieService {
    func getAllFirebaseMovies() -> Promise<[FirebaseMovie]> {
        return Promise { fulfill, reject in
            movieReference.observeSingleEvent(of: .value, with: { snapshot in
                var firebaseMovies: [FirebaseMovie] = []
                for child in snapshot.children.allObjects {
                    let item = child as! DataSnapshot
                    let val = item.value as? [String: Any] ?? [:]
                    let tmdb_id = String(describing: val["themoviedborg_id"]!)
                    let tmdb_title = String(describing: val["themoviedborg_id"]!)
                    let id = String(describing: val["movie_id"]!)
                    let firebaseMovie = FirebaseMovie(id: id, tmdb_title: tmdb_title, tmdb_id: tmdb_id)
                    firebaseMovies.append(firebaseMovie)
                }
                fulfill(firebaseMovies)
            })
        }
    }
}

extension FirebaseService: IFirebaseCinemaService {
    func getAllFirebaseCinemas() -> Promise<[FirebaseCinema]> {
        
        return Promise { fulfill, reject in
            cinemaReference.observeSingleEvent(of: .value, with: { snapshot in
                guard snapshot.hasChildren() else {
                    reject(CinemaServiceError.NoCinemasAvailable("No cinemas available"))
                    return
                }
                
                var cinemas: [FirebaseCinema] = []
                for item in snapshot.children.allObjects as! [DataSnapshot] {
                    let value = item.value as! [String: String]
                    
                    let id = item.key
                    let address = value["address"]!
                    let images = value["images"]!
                    let name = value["name"]!
                    let seatingArrangement = value["seating_arrangement"]!
                    
                    let cinema = FirebaseCinema(id: id, address: address, images: images, name: name, seatingArrangement: seatingArrangement)
                    cinemas.append(cinema)
                }
                
                fulfill(cinemas)
            })
        }

    }
}

extension FirebaseService: IFirebaseMovieSessionService {
    
    func getMovieSessions() -> Promise<[FirebaseMovieSession]> {
        return createMovieSessionPromise()
    }
    
    func getMovieSessions(byMovieId movieId: Int) -> Promise<[FirebaseMovieSession]> {
        let queryByMovieID = self.movieSessionReference.queryOrdered(byChild: "themoviedborg_id").queryEqual(toValue: movieId)
        return createMovieSessionPromise(queryByMovieID)
    }
    
    func getMovieSessions(byCinemaId cinemaId: String)  -> Promise<[FirebaseMovieSession]> {
        let queryCinemaID = self.movieSessionReference.queryOrdered(byChild: "cinema_id").queryEqual(toValue: cinemaId)
        return createMovieSessionPromise(queryCinemaID)
    }
    
    func getMovieSession(byId id: Int) -> Promise<FirebaseMovieSession> {
        let queryMovieSession = self.movieSessionReference.queryOrdered(byChild: "session_id").queryEqual(toValue: id)
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
    
    func createMovieSessionPromise() -> Promise<[FirebaseMovieSession]> {
        return Promise { fulfill, reject in
            self.movieSessionReference.observeSingleEvent(of: .value, with: { snapshot in
                guard snapshot.hasChildren() else {
                    reject(MovieSessionServiceError.NoMovieSessionsAvailable("No sessions available"))
                    return
                }
                
                let firebaseMovieSessions = self.convertSnapshot(toFirebaseMovieSessions: snapshot)
                fulfill(firebaseMovieSessions)
            })
        }
    }
    func createMovieSessionPromise(_ firebaseDatabaseQuery: DatabaseQuery) -> Promise<[FirebaseMovieSession]> {
        return Promise { fulfill, reject in
            firebaseDatabaseQuery.observeSingleEvent(of: .value, with: { snapshot in
                guard snapshot.hasChildren() else {
                    reject(MovieSessionServiceError.NoMovieSessionsAvailable("No sessions available"))
                    return
                }
                
                let firebaseMovieSessions = self.convertSnapshot(toFirebaseMovieSessions: snapshot)
                fulfill(firebaseMovieSessions)
            })
        }
    }
    
    // helper method
    // Converts Firebase movie session snapshot into array of FirebaseMovieSession objects
    func convertSnapshot(toFirebaseMovieSessions snapshot: DataSnapshot) -> [FirebaseMovieSession] {
        var firebaseMovieSessions: [FirebaseMovieSession] = []
        for item in snapshot.children.allObjects as! [DataSnapshot] {
            
            let val = item.value as? [String: Any] ?? [:]
            
            guard val["session_id"] != nil else {
                continue
            }
            guard val["starttime"] != nil else {
                continue
            }
            guard val["themoviedborg_id"] != nil else {
                continue
            }
            guard val["cinema_id"] != nil else {
                continue
            }
            
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

