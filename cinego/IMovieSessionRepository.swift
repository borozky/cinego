//
//  IMovieSessionRepository.swift
//  cinego
//
//  Created by Victor Orosco on 29/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

protocol IMovieSessionRepository {
    func getMovieSessions(byMovie movie: Movie) -> [MovieSession]
    func getMovieSessions(byCinema cinema: Cinema) -> [MovieSession]
}
