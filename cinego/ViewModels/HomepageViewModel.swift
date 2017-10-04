//
//  HomepageViewModel.swift
//  cinego
//
//  Created by 何家红 on 4/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import Alamofire

protocol HomePageViewModelDelegate: class {
    func homepageMoviesLoaded() -> Void
    func errorProduced(_ error: Error) -> Void
}

class HomePageViewModel {
    weak var delegate: HomePageViewModelDelegate?
    
    // ViewModel data
    var cinemaMovies: [(Cinema, [Movie])] = []
    var upcomingMovies: [Movie] = []
    var cinemas: [Cinema] = []
    
    
    // dependencies
    var movieService: IMovieService
    var cinemaService: ICinemaService
    var movieSessionService: IMovieSessionService
    init(movieService: IMovieService,
         cinemaService: ICinemaService, movieSessionService: IMovieSessionService) {
        self.movieService = movieService
        self.cinemaService = cinemaService
        self.movieSessionService = movieSessionService
    }
}

extension HomePageViewModel {
    
    public func loadHomePageMovies() {
        var movieSessions: [MovieSession] = []
        
        // 1. Load movies grouped by cinema
        // 2. Display upcoming movies
        movieSessionService.getMovieSessions().then { results -> Void in
            movieSessions = results.filter { $0.startTime > Date() }
            }.then {
                self.cinemaService.getAllCinemas()
            }.then { results -> Void in
                let cinemaMovies = self.getCinemaMovies(results, movieSessions)
                self.cinemaMovies = cinemaMovies
            }
            .then { () -> Void in
                let upcomingSessions = movieSessions.filter { $0.startTime > Date() }.sorted { a,b in
                    return a.startTime < b.startTime
                }
                
                // get all movies, remove duplicates
                var movies = [Movie]()
                upcomingSessions.forEach { movieSession in
                    if !movies.contains(where: { $0.id == movieSession.movie.id }) {
                        movies.append(movieSession.movie)
                    }
                }
                
                // get all upcoming movies
                if movies.count > 0 {
                    self.upcomingMovies = movies.map { movie in
                        return upcomingSessions.filter { $0.movie.id == movie.id }.sorted { $0.startTime < $1.startTime }.first!.movie
                    }
                }
            }.then { () -> Void in
                self.delegate?.homepageMoviesLoaded()
            }
            .catch { error in
                self.delegate?.errorProduced(error)
        }
    }
    
    // groups movieSessions by movies and cinemas
    func getCinemaMovies(_ cinemas: [Cinema], _ movieSessions: [MovieSession]) -> [(Cinema, [Movie])]{
        var cinemaMovieIds: [String: Set<Int>] = [:]
        for cinema in cinemas {
            cinemaMovieIds[cinema.id] = []
        }
        
        for movieSession in movieSessions {
            let movieIdInt = Int(movieSession.movie.id)!
            cinemaMovieIds[movieSession.cinema.id]?.insert(movieIdInt)
        }
        
        let moviesArray: [Movie] = movieSessions.reduce([], { movies, movieSession in
            if movies.contains(where: { $0.id == movieSession.movie.id }) {
                return movies
            } else {
                var newMovie = movies
                newMovie.append(movieSession.movie)
                return newMovie
            }
        })
        
        var cinemaMovies: [(Cinema, [Movie])] = []
        for cinema in cinemas {
            let movies = moviesArray.filter { movie in
                return (cinemaMovieIds[cinema.id]?.contains( Int(movie.id)! ))!
            }
            cinemaMovies.append((cinema, movies))
        }
        
        return cinemaMovies
    }
    
}

