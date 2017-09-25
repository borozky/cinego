//
//  MovieSessionServiceTests.swift
//  cinego
//
//  Created by Josh MacDev on 22/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import XCTest
import PromiseKit
import Firebase
import SwiftyJSON
@testable import cinego

class MovieSessionServiceTests: XCTestCase {
    
    var movieSessionService: IMovieSessionService!
    var movieService: IMovieService!
    var cinemaService: ICinemaService!
    var firebaseMovieSessionService: IFirebaseMovieSessionService!
    
    override func setUp() {
        super.setUp()
        
        self.movieService = MockMovieService()
        self.cinemaService = MockCinemaService()
        self.firebaseMovieSessionService = MockFirebaseMovieSessionService()
        self.movieSessionService = MovieSessionService(movieService: movieService, cinemaService: cinemaService, firebaseMovieSessionService: firebaseMovieSessionService)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_movieSessions() {
        // TODO: ...
    }
    
}

enum MockError: Error {
    case NotFound
}
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

class MockMovieService: IMovieService {
    var movies: [Movie] = [
        Movie(id: "1",
              title: "Alien Covenant",
              releaseDate: "19 May 2017",
              duration: 122,
              details: "Bound for a remote planet on the far side of the galaxy, the crew of the colony ship 'Covenant' discovers what is thought to be an uncharted paradise, but is actually a dark, dangerous world – which has its sole inhabitant the 'synthetic', David, survivor of the doomed Prometheus expedition.",
              contentRating: .MA15_PLUS,
              images: ["alien_covenant"]),
        Movie(id: "2",
              title: "Baby Driver",
              releaseDate: "11 March 2017",
              duration: 113,
              details: "After being coerced into working for a crime boss, a young getaway driver finds himself taking part in a heist doomed to fail.",
              contentRating: .MA15_PLUS,
              images: ["baby_driver"]),
        Movie(id: "3",
              title: "Boyka: Undisputed IV",
              releaseDate: "22 September 2017",
              duration: 87,
              details: "In the fourth installment of the fighting franchise, Boyka is shooting for the big leagues when an accidental death in the ring makes him question everything he stands for. When he finds out the wife of the man he accidentally killed is in trouble, Boyka offers to fight in a series of impossible battles to free her from a life of servitude",
              contentRating: .PG,
              images: ["boyka_undisputed_4"]),
        Movie (id: "4",
               title: "Dawn of the Planet of the Apes",
               releaseDate: "21 July 2017",
               duration: 90,
               details: "A group of scientists in San Francisco struggle to stay alive in the aftermath of a plague that is wiping out humanity, while Caesar tries to maintain dominance over his community of intelligent apes.",
               contentRating: .MA15_PLUS,
               images: ["dawn_of_the_planet_of_the_apes"]),
        Movie (id: "5",
               title: "Despicable Me 3",
               releaseDate: "1 July 2016" ,
               duration: 128,
               details: "Gru and his wife Lucy must stop former '80s child star Balthazar Bratt from achieving world domination.",
               contentRating: .G,
               images: ["despicable_me_3"]),
        Movie (id: "6",
               title: "Doctor Strange",
               releaseDate: "1 July 2017",
               duration: 108,
               details: "After his career is destroyed, a brilliant but arrogant surgeon gets a new lease on life when a sorcerer takes him under his wing and trains him to defend the world against evil.",
               contentRating: .PG,
               images: ["doctor_strange"])
    ]

    func findMovie(_ id: Int) -> Promise<Movie> {
        let movie = movies.filter { $0.id == String(id) }
        guard movie.count > 0 else {
            return Promise(error: MockError.NotFound)
        }
        return Promise(value: movie.first!)
    }
    
    func getAllMovies() -> Promise<[Movie]> {
        return Promise(value: movies)
    }
    
    func getAllMovies(byIds ids: [Int]) -> Promise<[Movie]> {
        let filtered = movies.filter { movie in
            return ids.contains(Int(movie.id)!)
        }
        guard filtered.count > 0 else {
            return Promise(error: MockError.NotFound)
        }
        return Promise(value: filtered)
    }
}

class MockCinemaService: ICinemaService {
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
