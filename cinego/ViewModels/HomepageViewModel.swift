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
    func cinemasRetrieved(_ cinemas: [Cinema]) -> Void
    func cinemaMoviesRetrieved(_ cinemaMovies: [(Cinema, [Movie])]) -> Void
    func upcomingMoviesRetrieved(_ upcomingMovies: [Movie]) ->  Void
    func errorProduced(_ message: String) -> Void
}

class HomePageViewModel {
    
    weak var delegate: HomePageViewModelDelegate?
    var movieService: IMovieService
    var cinemaService: ICinemaService
    var movieSessionService: IMovieSessionService
    
    init(movieService: IMovieService,
         cinemaService: ICinemaService, movieSessionService: IMovieSessionService) {
        self.movieService = movieService
        self.cinemaService = cinemaService
        self.movieSessionService = movieSessionService
    }
    
    // Fetch all cinema info. 
    // HomePageViewModelDelegate.cinemasRetrieved is called after fetching
    public func fetchAllCinemas() {
        self.cinemaService.getAllCinemas().then { cinemas -> Void in
            self.delegate?.cinemasRetrieved(cinemas)
        }.catch { error in
            self.delegate?.errorProduced("")
        }
    }
    
    public func fetchUpcomingMovies() {
        self.movieService.getAllMovies().then { movies -> Void in
            let limitedMovies = movies
            self.delegate?.upcomingMoviesRetrieved(limitedMovies)
        }.catch { error in
            self.delegate?.errorProduced("")
        }
    }
    
    public func fetchCinemaMovies() {
        var movieSessions: [MovieSession] = []
        
        movieSessionService.getMovieSessions().then { results -> Void in
            movieSessions = results
        }.then {
            self.cinemaService.getAllCinemas()
        }.then { results -> Void in
            let cinemaMovies = self.getCinemaMovies(results, movieSessions)
            self.delegate?.cinemaMoviesRetrieved(cinemaMovies)
        }.catch { error in
            print(error)
        }
    }
    
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

