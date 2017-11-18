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

var MOVIECACHE = [String: Movie]()
var MOVIEJSONCACHE = [String: JSON]()

// Use Promise to delegate processing data to callers
protocol IMovieService: class {
    func findMovie(_ id: Int) -> Promise<Movie>
    func getAllMovies() -> Promise<[Movie]>
    func getAllMovies(byIds ids: [Int]) -> Promise<[Movie]>
}


class MovieService: IMovieService {
    
    // Dependencies
    // Movie service depends on Firebase service wrappers and CoreData repositories
    var firebaseMovieService: IFirebaseMovieService
    var tmdbMovieService: ITMDBMovieService
    var movieCoreDataRepository: MovieCoreDataRepository
    init(tmdbMovieService: ITMDBMovieService, firebaseMovieService: IFirebaseMovieService, movieRepository: MovieCoreDataRepository){
        self.tmdbMovieService = tmdbMovieService
        self.firebaseMovieService = firebaseMovieService
        self.movieCoreDataRepository = movieRepository
    }
    
    
    // Find movie by TMDB ID
    // It will try to load from cache first or otherwise get data from API
    func findMovie(_ id: Int) -> Promise<Movie> {
        // check if exists in the cache
        if let movieInCache = MOVIECACHE[String(id)] {
            return Promise(value: movieInCache)
        }
        
        // find with TMDB service
        return tmdbMovieService.findTMDBMovie(id).then { result in
            let movie = try Movie(json: result)
            
            // cache json results
            MOVIECACHE[String(id)] = movie
            MOVIEJSONCACHE[String(id)] = result
            
            return Promise(value: movie)
        }
    }
    
    // Gets all movies
    func getAllMovies() -> Promise<[Movie]> {
        return firebaseMovieService.getAllFirebaseMovies().then { firebaseMovies in
            return when(fulfilled: firebaseMovies.map { firebaseMovie in
                return self.findMovie( Int(firebaseMovie.tmdb_id)! )
            })
        }
    }
    
    // Gets all movies based on TMDB IDs given
    func getAllMovies(byIds ids: [Int]) -> Promise<[Movie]> {
        return when(fulfilled: ids.map { id in
            return self.findMovie(id)
        })
    }
}
