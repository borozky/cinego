//
//  HomepageViewModel.swift
//  cinego
//
//  Created by 何家红 on 4/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class HomePageViewModel {
    
    private var movieRepository: IMovieRepository
    private var cinemaRepository: ICinemaRepository
 
    init(_ movieRepository: IMovieRepository, _ cinemaRepository: ICinemaRepository){
        self.movieRepository = movieRepository
        self.cinemaRepository = cinemaRepository
    }
    
    
    public func getAllCinemas() -> [Cinema] {
        return cinemaRepository.getAllCinemas()
    }
    
    
    public func getUpcomingMovies() -> [Movie] {
        return movieRepository.getUpcomingMovies()
    }
    
    
    public func getCinemaMovies () -> [(Cinema, [Movie])] {
        var cinemaMovies: [(Cinema, [Movie])] = []
        let cinemas = getAllCinemas()
        for cinema in cinemas {
            let movies = movieRepository.getMovies(byCinema: cinema)
            cinemaMovies.append ((cinema, movies))
        }
        
        return cinemaMovies
    }
    
}
