//
//  MovieSessionRepository.swift
//  cinego
//
//  Created by 何家红 on 14/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation


protocol IMovieSessionRepository {
    func getMovieSessions(byMovie movie: Movie) -> [MovieSession]
    func getMovieSession(byId id: String) -> MovieSession?
    func getMovieSessions(byCinema cinema: Cinema) -> [MovieSession]
    
    func find(byId id: String) -> MovieSession?
    func findAll(byMovie movie: Movie) -> [MovieSession]
    func findAll(byCinema cinema: Cinema) -> [MovieSession]
}


class MovieSessionRepository: IMovieSessionRepository {
    
    let movieRepository: IMovieRepository? = MovieRepository()
    let cinemaRepository: ICinemaRepository? = CinemaRepository()
    var movieSessions: [MovieSession] = []
    
    
    init(){
        for i in 1...100 {
            let movie = getRandomMovie()
            let cinema = getRandomCinema()
            let date = getRandomDate()
            movieSessions.append(MovieSession(id: i, startTime: date, cinema: cinema, movieId: movie.id!))
        }
    }
    
    func find(byId id: String) -> MovieSession? {
        return nil
    }
    
    func findAll(byMovie movie: Movie) -> [MovieSession] {
        return []
    }
    
    func findAll(byCinema cinema: Cinema) -> [MovieSession] {
        return []
    }
    
    
    func getMovieSessions(byMovie movie: Movie) -> [MovieSession] {
        var sessions: [MovieSession] = []
        for movieSession in movieSessions {
            if movieSession.movieId == movie.id {
                sessions.append(movieSession)
            }
        }
        return sessions
    }
    
    
    
    func getMovieSessions(byCinema cinema: Cinema) -> [MovieSession] {
        var sessions: [MovieSession] = []
        for movieSession in movieSessions {
            if movieSession.cinema?.id == cinema.id {
                sessions.append(movieSession)
            }
        }
        return sessions
    }
    
    
    func getMovieSession(byId id: String) -> MovieSession? {
        for movieSession in movieSessions {
            if String(movieSession.id!) == id {
                return movieSession
            }
        }
        return nil
    }
    
    
    // helper methods
    
    private func getRandomCinema() -> Cinema {
        let cinemas = cinemaRepository?.getAllCinemas()
        let numCinemas = Int(cinemas?.count ?? 0)
        let randomNumber = Int(arc4random_uniform(UInt32(numCinemas)))
        return cinemas![randomNumber]
    }
    
    private func getRandomMovie() -> Movie {
        let movies = movieRepository?.getUpcomingMovies()
        let numMovies = movies?.count ?? 0
        let randomNumber = Int(arc4random_uniform(UInt32(numMovies)))
        return movies![randomNumber]
    }
    
    private func getRandomDate() -> String {
        let randomDay = Int(arc4random_uniform(UInt32(28))) + 1
        let randomMonth = Int(arc4random_uniform(UInt32(12))) + 1
        let randomYear = Int(arc4random_uniform(UInt32(1))) + 2017
        let randomHour = Int(arc4random_uniform(UInt32(24)))
        let randomMinute = Int(arc4random_uniform(UInt32(60)))
        
        let randomDate = "\(NSString(format: "%02d", randomDay))-\(NSString(format: "%02d", randomMonth))-\(String(randomYear)) \(NSString(format: "%02d", randomHour)):\(NSString(format: "%02d", randomMinute)):00"
        
        return randomDate
    }
    
}
