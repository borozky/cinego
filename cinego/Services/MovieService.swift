//
//  MovieService.swift
//  cinego
//
//  Created by Josh MacDev on 19/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON
import Firebase
import Haneke


// Use Promise to delegate processing data to callers
protocol IMovieService: class {
    func findMovie(_ id: Int) -> Promise<Movie>
    func getAllMovies() -> Promise<[Movie]>
    func getAllMovies(byIds ids: [Int]) -> Promise<[Movie]>
}


class MovieService: IMovieService {
    var firebaseMovieService: IFirebaseMovieService
    var tmdbMovieService: ITMDBMovieService
    
    init(tmdbMovieService: ITMDBMovieService, firebaseMovieService: IFirebaseMovieService){
        self.tmdbMovieService = tmdbMovieService
        self.firebaseMovieService = firebaseMovieService
    }
    
    func findMovie(_ id: Int) -> Promise<Movie> {
        return tmdbMovieService.findTMDBMovie(id).then { result in
            return try Movie(json: result)
        }
    }
    
    func getAllMovies() -> Promise<[Movie]> {
        return firebaseMovieService.getAllFirebaseMovies().then { firebaseMovies in
            return when(fulfilled: firebaseMovies.map { firebaseMovie in
                return self.findMovie( Int(firebaseMovie.tmdb_id)! )
            })
        }
    }
    
    func getAllMovies(byIds ids: [Int]) -> Promise<[Movie]> {
        return when(fulfilled: ids.map { id in
            return self.findMovie(id)
        })
    }
}
