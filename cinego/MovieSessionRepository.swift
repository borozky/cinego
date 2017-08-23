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
    func findUpcomingMovieSession(fromMovie movie: Movie) -> MovieSession?
    func findAll(byMovie movie: Movie) -> [MovieSession]
    func findAll(byCinema cinema: Cinema) -> [MovieSession]
}


class MovieSessionRepository: IMovieSessionRepository {
    
    var movieRepository: IMovieRepository? = MovieRepository()
    var cinemaRepository: ICinemaRepository? = CinemaRepository()
    
    var movieSessions: [MovieSession] = []
    
    // generate 100 mock sessions
    init(){
        for i in 1...100 {
            let movie = getRandomMovie()
            let cinema = getRandomCinema()
            let date = getRandomDate()  // dd-MM-yyyy HH:mm:ss
            
            movieSessions.append(MovieSession(id: String(i), startTime: date, cinema: cinema, movie: movie))
        }
    }
    
    
    func find(byId id: String) -> MovieSession? {
        return movieSessions.filter { $0.id == id }.first ?? nil
    }
    
    func findAll(byMovie movie: Movie) -> [MovieSession] {
        let filtered = movieSessions.filter { $0.id == movie.id }
        return sort(filtered)
        
    }
    
    
    func findAll(byCinema cinema: Cinema) -> [MovieSession] {
        return movieSessions.filter { cinema.id == $0.cinema.id }
    }
    
    
    func findUpcomingMovieSession(fromMovie movie: Movie) -> MovieSession? {
        let movieSessionsByMovie: [MovieSession] = getMovieSessions(byMovie: movie)
        
        if movieSessionsByMovie.count == 0 {
            return nil
        }
        
        if movieSessionsByMovie.count == 1 {
            return movieSessionsByMovie[0]
        }
        
        return sort(movieSessionsByMovie)[0]
    }
    
    
    
    func getMovieSessions(byMovie movie: Movie) -> [MovieSession] {
        let sessions = movieSessions.filter { $0.movie.id == movie.id }
        return sort(sessions)
    }
    
    
    func getMovieSessions(byCinema cinema: Cinema) -> [MovieSession] {
        let sessions = movieSessions.filter { $0.cinema.id == cinema.id }
        return sort(sessions)
    }
    
    
    func getMovieSession(byId id: String) -> MovieSession? {
        return movieSessions.filter { $0.id == id }.first ?? nil
    }
    
    
    func sort(_ movieSessions: [MovieSession]) -> [MovieSession]{
        return movieSessions.sorted(by: { sessionA, sessionB -> Bool in
            return sessionA.startTime < sessionB.startTime
        })
    }
    
    
    // helper methods for generating random sessions
    
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
    
    private func getRandomDate() -> Date {
        let randomDay = Int(arc4random_uniform(UInt32(28))) + 1
        let randomMonth = Int(arc4random_uniform(UInt32(12))) + 1
        let randomYear = Int(arc4random_uniform(UInt32(1))) + 2017
        let randomHour = Int(arc4random_uniform(UInt32(24)))
        let randomMinute = Int(arc4random_uniform(UInt32(60)))
        let randomDateStr = "\(String(format: "%02d", randomDay))-\(String(format: "%02d", randomMonth))-\(String(randomYear)) \(String(format: "%02d", randomHour)):\(String(format: "%02d", randomMinute)):00"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return formatter.date(from: randomDateStr)!
    }
    
}
