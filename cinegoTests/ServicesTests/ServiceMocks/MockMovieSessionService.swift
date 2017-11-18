//
//  MockMovieSessionService.swift
//  cinego
//
//  Created by Josh MacDev on 25/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit
@testable import cinego

class MockMovieSessionService: IMovieSessionService {
    
    var movieSessions: [MovieSession] = []
    
    var cinemaService: ICinemaService
    var movieService: IMovieService
    var firebaseMovieSessionService: IFirebaseMovieSessionService
    init(movieService: IMovieService, cinemaService: ICinemaService, firebaseMovieSessionService: IFirebaseMovieSessionService){
        self.movieService = movieService
        self.cinemaService = cinemaService
        self.firebaseMovieSessionService = firebaseMovieSessionService
        
        
        // 1
        let mockCinemaImpl = MockCinemaService()
        let mockMovieImpl = MockMovieService()
        movieSessions.append( MovieSession(id: "12345", startTime: Date(), cinema: mockCinemaImpl.cinemas[0], movie: mockMovieImpl.movies[0]) )
    }
    
    func getMovieSession(byId id: Int) -> Promise<MovieSession> {
        guard let movieSession = movieSessions.first(where: { $0.id == String(id) }) else {
            return Promise(error: MockError.NotFound)
        }
        return Promise(value: movieSession)
    }
    func getMovieSessions() -> Promise<[MovieSession]> {
        return Promise(value: movieSessions)
    }
    func getMovieSessions(byCinemaId cinemaId: String) -> Promise<[MovieSession]> {
        let movieSessions = self.movieSessions.filter { $0.cinema.id == cinemaId }
        guard movieSessions.count > 0 else {
            return Promise(error: MockError.NotFound)
        }
        return Promise(value: movieSessions)
    }
    func getMovieSessions(byMovieId movieId: Int) -> Promise<[MovieSession]> {
        let movieSessions = self.movieSessions.filter { $0.movie.id == String(movieId) }
        guard movieSessions.count > 0 else {
            return Promise(error: MockError.NotFound)
        }
        return Promise(value: movieSessions)
    }
}
