//
//  IMovieRepository.swift
//  cinego
//
//  Created by Victor Orosco on 29/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol IMovieRepository {
    func getUpcomingMovies() -> [Movie]
    func getUpcomingMovies(fromCinema cinema: Cinema) -> [Movie]
    func getMovie(byId id: Int) -> Movie?
    func getMovies(byTitle title: String) -> [Movie]
    func getMovies(byCinema cinema: Cinema) -> [Movie]
    
    func searchMovie(byKeyword keyword: String) -> [Movie]
}
