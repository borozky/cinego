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
    
    let tmdb_apikey = "8e91ab723e730b59175061f4aa1ed37c"
    let tdmb_movieUrl = "https://api.themoviedb.org/3/movie/"
    let tmdb_imageUrl = "https://image.tmdb.org/t/p/w500"
    let JSONCache = Shared.JSONCache
    let firebaseMovieReference = Database.database().reference().child("movies")
    
    
    // circular dependency between this class and IMovieSessionService
    var movieSessionService: IMovieSessionService?
    public func setMovieSessionService(_ movieSessionService: IMovieSessionService) {
        self.movieSessionService = movieSessionService
    }
    
    private func movieUrl(_ id: Int) -> String {
        return "\(tdmb_movieUrl)\(String(id))?api_key=\(tmdb_apikey)"
    }
    
    private func posterUrl(_ posterFilename: String) -> String {
        return "\(tmdb_imageUrl)\(posterFilename)?api_key=\(tmdb_apikey)"
    }
    
    
    
    
    
    
    
    
    
    // Find movie by TMDB ID. Cache the results
    func findMovie(_ id: Int) -> Promise<Movie> {
        let url = URL(string: "\(tdmb_movieUrl)\(String(id))?api_key=\(tmdb_apikey)")!
        
        return Promise { fulfill, reject in
            JSONCache.fetch(URL: url).onSuccess { result in
                do {
                    // model entities uses SwiftyJSON.JSON instead of Haneke.JSON
                    var json = SwiftyJSON.JSON(result.asData())
                    
                    // original poster path is displayed as filename (eg. /2sd8tv0d88h9hj0vy5u6kg7v.jpg)
                    // need to convert into full url
                    let posterPath = json["poster_path"].stringValue
                    let posterUrl = self.posterUrl(posterPath)
                    json["poster_path"] = SwiftyJSON.JSON(posterUrl)
                    
                    // let the Movie entity convert this JSON to actual model. Could fail
                    let movie = try Movie(json: json)
                    fulfill(movie)
                } catch let error {
                    reject(error)
                }
                }.onFailure { error in
                    reject(error!)
            }
        }
    }
    
    
    // Get all TMDB IDs from Firebase, then retrieve details info from TMDB
    func getAllMovies() -> Promise<[Movie]> {
        let movieReference = self.firebaseMovieReference
        
        return Promise { fulfill, reject in
            movieReference.observeSingleEvent(of: .value, with: { snapshot in
                
                var movies: [Movie] = []
                
                // retrieve all movies one after another sequentially
                when(fulfilled: snapshot.children.allObjects.map {
                    
                    /* firebase snapshot json format is like this
                     {
                     id: ...,
                     themoviedborg_id: ...,
                     themoviedborg_title: ...
                     }
                     */
                    let item = $0 as! DataSnapshot
                    let val = item.value as? [String: Any] ?? [:]
                    let tmdb_id = String(describing: val["themoviedborg_id"]!)
                    
                    return self.findMovie( Int(tmdb_id)! ).then {
                        movies.append($0)
                    }
                }).then {
                    fulfill(movies)
                }.catch { error in
                    reject(error)
                }
            })
        }
    }
    
    func getAllMovies(byIds ids: [Int]) -> Promise<[Movie]> {
        return Promise { fulfill, reject in
            var movies: [Movie] = []
            
            when(resolved: ids.map { id in
                return self.findMovie(id).then {
                    movies.append($0)
                }
            }).then { _ in
                fulfill(movies)
            }.catch { error in
                reject(error)
            }
        }
    }
    
}
