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
        movies.append(Movie(title: "Movie 1", releaseDate: "2017", duration: 140, sessions: [], images: []))
        movies.append(Movie(title: "Movie 2", releaseDate: "2017", duration: 138, sessions: [], images: []))
        movies.append(Movie(title: "Movie 3", releaseDate: "2017", duration: 160, sessions: [], images: []))
        movies.append(Movie(title: "Movie 4", releaseDate: "2017", duration: 170, sessions: [], images: []))
        movies.append(Movie(title: "Movie 5", releaseDate: "2017", duration: 200, sessions: [], images: []))
        movies.append(Movie(title: "Movie 7", releaseDate: "2017", duration: 150, sessions: [], images: []))
        return movies
    }
    
    
    func getMovies(title: String) -> [Movie] {
        var movies: [Movie] = []
        movies.append(Movie(title: "Movie 1", releaseDate: "2017", duration: 140, sessions: [], images: []))
        movies.append(Movie(title: "Movie 2", releaseDate: "2017", duration: 138, sessions: [], images: []))
        movies.append(Movie(title: "Movie 3", releaseDate: "2017", duration: 160, sessions: [], images: []))
        movies.append(Movie(title: "Movie 4", releaseDate: "2017", duration: 170, sessions: [], images: []))
        movies.append(Movie(title: "Movie 5", releaseDate: "2017", duration: 200, sessions: [], images: []))
        movies.append(Movie(title: "Movie 7", releaseDate: "2017", duration: 150, sessions: [], images: []))
        return movies
    }
    
    
    func getMovie(id: Int) -> Movie {
        return Movie(title: "Movie 1", releaseDate: "12 July 2017", duration: 140, sessions: [], images: [])
    }
    
    
    func getMovies(byCinema: Cinema) -> [Movie] {
        var movies: [Movie] = []
        movies.append(Movie(title: "Movie 1", releaseDate: "2017", duration: 140, sessions: [], images: []))
        movies.append(Movie(title: "Movie 2", releaseDate: "2017", duration: 138, sessions: [], images: []))
        movies.append(Movie(title: "Movie 3", releaseDate: "2017", duration: 160, sessions: [], images: []))
        movies.append(Movie(title: "Movie 4", releaseDate: "2017", duration: 170, sessions: [], images: []))
        movies.append(Movie(title: "Movie 5", releaseDate: "2017", duration: 200, sessions: [], images: []))
        movies.append(Movie(title: "Movie 7", releaseDate: "2017", duration: 150, sessions: [], images: []))
        return movies
    }
    
    
    func getUpcomingMovies(fromCinema cinema: Cinema) -> [Movie] {
        var movies: [Movie] = []
        movies.append(Movie(title: "Movie 1", releaseDate: "2017", duration: 140, sessions: [], images: []))
        movies.append(Movie(title: "Movie 2", releaseDate: "2017", duration: 138, sessions: [], images: []))
        movies.append(Movie(title: "Movie 3", releaseDate: "2017", duration: 160, sessions: [], images: []))
        movies.append(Movie(title: "Movie 4", releaseDate: "2017", duration: 170, sessions: [], images: []))
        movies.append(Movie(title: "Movie 5", releaseDate: "2017", duration: 200, sessions: [], images: []))
        movies.append(Movie(title: "Movie 7", releaseDate: "2017", duration: 150, sessions: [], images: []))
        return movies
    }
    
    func searchMovie(byKeyword keyword: String) -> [Movie] {
        var movies: [Movie] = []
        movies.append(Movie(title: "Movie 1", releaseDate: "2017", duration: 140, sessions: [], images: []))
        movies.append(Movie(title: "Movie 2", releaseDate: "2017", duration: 138, sessions: [], images: []))
        movies.append(Movie(title: "Movie 3", releaseDate: "2017", duration: 160, sessions: [], images: []))
        movies.append(Movie(title: "Movie 4", releaseDate: "2017", duration: 170, sessions: [], images: []))
        movies.append(Movie(title: "Movie 5", releaseDate: "2017", duration: 200, sessions: [], images: []))
        movies.append(Movie(title: "Movie 7", releaseDate: "2017", duration: 150, sessions: [], images: []))
        return movies
    }
    
}
