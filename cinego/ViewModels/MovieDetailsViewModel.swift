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
    
    var delegate: MovieDetailsViewModelDelegate?
    var movieSessionService: IMovieSessionService
    var movieService: IMovieService
    
    init(movieSessionService: IMovieSessionService, movieService: IMovieService){
        self.movieSessionService = movieSessionService
        self.movieService = movieService
    }
    
    func fetchMovieDetails(_ movieId: Int) {
        movieService.findMovie(movieId).then { movie -> Void in
            self.delegate?.movieDetailsRetrieved(movie)
        }.catch { error in
            self.delegate?.errorProduced()
        }
    }
    
    func fetchMovieSessions(byMovieId movieId: Int) {
        movieSessionService.getMovieSessions(byMovieId: movieId).then { movieSessions -> Void in
            self.delegate?.movieSessionsRetrieved(movieSessions)
        }.catch { error in
            self.delegate?.errorProduced()
        }
    }
    
}
