//
//  TMDBMovieService.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit
import Haneke
import SwiftyJSON

let TMDBJSONCache = Shared.JSONCache

// Service to retrieve movie information from TMDB API
// Can only get 1 movie at a time

protocol ITMDBMovieService: class {
    func findTMDBMovie(_ id: Int) -> Promise<SwiftyJSON.JSON>
}


class TMDBMovieService: ITMDBMovieService {
    
    let tmdb_apikey = "8e91ab723e730b59175061f4aa1ed37c"
    let tdmb_movieUrl = "https://api.themoviedb.org/3/movie/"
    let tmdb_imageUrl = "https://image.tmdb.org/t/p/w500"
    
    private func movieUrl(_ id: Int) -> String {
        return "\(tdmb_movieUrl)\(String(id))?api_key=\(tmdb_apikey)"
    }
    
    private func posterUrl(_ posterFilename: String) -> String {
        return "\(tmdb_imageUrl)\(posterFilename)?api_key=\(tmdb_apikey)"
    }
    
    // Find movie by TMDB ID. Cache the results
    func findTMDBMovie(_ id: Int) -> Promise<SwiftyJSON.JSON> {
        
        let url = URL(string: "\(tdmb_movieUrl)\(String(id))?api_key=\(tmdb_apikey)")!
        
        return Promise { fulfill, reject in
            TMDBJSONCache.fetch(URL: url).onSuccess { result in
                
                var json = SwiftyJSON.JSON(result.asData()) // result uses Haneke.JSON
                
                // original poster path is displayed as filename (eg. /2sd8tv0d88h9hj0vy5u6kg7v.jpg)
                // need to convert into full url
                let posterPath = json["poster_path"].stringValue
                let posterUrl = self.posterUrl(posterPath)
                json["poster_path"] = SwiftyJSON.JSON(posterUrl)
                fulfill(json)
                
            }.onFailure { error in
                print("failed url: \(url.absoluteString)")
                reject(error!)
            }
        }
    }
}
