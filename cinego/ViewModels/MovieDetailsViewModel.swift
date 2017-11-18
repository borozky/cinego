//
//  MovieDetailsViewModel.swift
//  cinego
//
//  Created by Josh MacDev on 22/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModelDelegate: class {
    func movieSessionsRetrieved(_ movieSessions: [MovieSession]) -> Void
    func movieDetailsRetrieved(_ movie: Movie) -> Void
    func errorProduced() -> Void
}


class MovieDetailsViewModel {
    static var selectedSeatsForSessions: [(MovieSession, [Seat])] = []
    var delegate: MovieDetailsViewModelDelegate?
    
    // ViewModel data
    var movie: Movie! {
        didSet { self.delegate?.movieDetailsRetrieved(self.movie) }
    }
    var movieSessions: [MovieSession] = [] {
        didSet { self.delegate?.movieSessionsRetrieved(self.movieSessions) }
    }
    
    // Group movie sessions by cinema
    var movieSessionsByCinema: [(Cinema, [MovieSession])] {
        var _movieSessionsByCinema: [(Cinema, [MovieSession])] = []
        let cinemas = movieSessions.map {$0.cinema}
        var _cinemas: [Cinema] = []
        for cinema in cinemas {
            let exists = _cinemas.contains(where: { $0.id == cinema.id })
            if exists {
                continue
            }
            _cinemas.append(cinema)
        }
        for cinema in _cinemas {
            let sessions = movieSessions.filter{ $0.cinema.id == cinema.id }
            _movieSessionsByCinema.append((cinema, sessions))
        }
        return _movieSessionsByCinema
    }
    
    
    // dependencies
    var movieSessionService: IMovieSessionService
    var movieService: IMovieService
    init(movieSessionService: IMovieSessionService, movieService: IMovieService){
        self.movieSessionService = movieSessionService
        self.movieService = movieService
    }
}


extension MovieDetailsViewModel {
    func fetchMovieDetails(_ movieId: Int) {
        movieService.findMovie(movieId).then { movie -> Void in
            self.movie = movie
        }.catch { error in
            self.delegate?.errorProduced()
        }
    }
    
    func fetchMovieSessions(byMovieId movieId: Int) {
        movieSessionService.getMovieSessions(byMovieId: movieId).then { movieSessions -> Void in
            self.movieSessions = movieSessions.sorted { $0.startTime < $1.startTime }
        }.catch { error in
            self.delegate?.errorProduced()
        }
    }
    
}
