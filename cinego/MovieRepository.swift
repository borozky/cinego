//
//  MovieRepository.swift
//  cinego
//
//  Created by Victor Orosco on 29/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class MovieRepository : IMovieRepository {
    
    func getUpcomingMovies() -> [Movie] {
        var movies: [Movie] = []
        
        
        var movie = Movie(title: "Alien Covenant", releaseDate: "19 May 2017", duration: 122, sessions: [], images: ["alien_covenant"])
        movie.id = 1
        movie.details = "Bound for a remote planet on the far side of the galaxy, the crew of the colony ship 'Covenant' discovers what is thought to be an uncharted paradise, but is actually a dark, dangerous world – which has its sole inhabitant the 'synthetic', David, survivor of the doomed Prometheus expedition."
        movies.append(movie)
        
        
        movie = Movie(title: "Baby Driver", releaseDate: "11 March 2017", duration: 113, sessions: [], images: ["baby_driver"])
        movie.id = 2
        movie.details = "After being coerced into working for a crime boss, a young getaway driver finds himself taking part in a heist doomed to fail."
        movies.append(movie)
        
        
        movie = Movie(title: "Boyka: Undisputed IV", releaseDate: "22 September 2017", duration: 87, sessions: [], images: ["boyka_undisputed_4"])
        movie.id = 3
        movie.details = "In the fourth installment of the fighting franchise, Boyka is shooting for the big leagues when an accidental death in the ring makes him question everything he stands for. When he finds out the wife of the man he accidentally killed is in trouble, Boyka offers to fight in a series of impossible battles to free her from a life of servitude"
        movies.append(movie)
        

        return movies
    }
    
    
    
    func getMovies(byTitle title: String) -> [Movie] {
        var results: [Movie] = []
        for movie in getUpcomingMovies() {
            if movie.title.lowercased() == title.lowercased() {
                results.append(movie)
            }
        }
        return results
    }
    
    
    
    func getMovie(byId id: Int) -> Movie? {
        let movies = getUpcomingMovies()
        for movie in movies {
            if movie.id == id {
                return movie
            }
        }
        return nil
    }
    
    
    
    func getMovies(byCinema cinema: Cinema) -> [Movie] {
        return getUpcomingMovies()
    }
    
    
    
    func getUpcomingMovies(fromCinema cinema: Cinema) -> [Movie] {
        return getUpcomingMovies()
    }
    
    
    
    func searchMovie(byKeyword keyword: String) -> [Movie] {
        return getUpcomingMovies()
    }
    
}
