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
            
            movieSessions.append(MovieSession(id: i, startTime: date, cinema: cinema, movieId: movie.id!))
        }
    }
    
    
    func find(byId id: String) -> MovieSession? {
        return movieSessions.filter {
            return String($0.id ?? 0) == id
        }.first ?? nil
    }
    
    
    func findAll(byMovie movie: Movie) -> [MovieSession] {
        let filtered = movieSessions.filter {
            return $0.movieId! == movie.id!
        }
        
        return sort(filtered)
        
    }
    
    
    func findAll(byCinema cinema: Cinema) -> [MovieSession] {
        return movieSessions.filter {
            return cinema.id! == $0.cinema!.id!
        }
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
        let sessions = movieSessions.filter {
            return $0.movieId == movie.id
        }
        return sort(sessions)
    }
    
    
    func getMovieSessions(byCinema cinema: Cinema) -> [MovieSession] {
        let sessions = movieSessions.filter {
            return $0.cinema?.id == cinema.id
        }
        return sort(sessions)
    }
    
    
    func getMovieSession(byId id: String) -> MovieSession? {
        for movieSession in movieSessions {
            if String(movieSession.id!) == id {
                return movieSession
            }
        }
        return nil
    }
    
    
    func sort(_ movieSessions: [MovieSession]) -> [MovieSession]{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        
        return movieSessions.sorted(by: { sessionA, sessionB -> Bool in
            let dateA = formatter.date(from: sessionA.startTime!)!
            let dateB = formatter.date(from: sessionB.startTime!)!
            return dateA < dateB
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
