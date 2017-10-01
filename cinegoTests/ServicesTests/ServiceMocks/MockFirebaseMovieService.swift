//
//  MockFirebaseMovieService.swift
//  cinego
//
//  Created by Josh MacDev on 25/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit
import Firebase
@testable import cinego

/*
 let movie_id = json["id"].rawString()!
 let movie_title = json["title"].rawString()!
 let movie_release_date = json["release_date"].rawString()!
 let movie_duration = json["runtime"].intValue
 let movie_details = json["overview"].rawString()!
 let movie_poster = json["poster_path"].rawString()
 guard json["poster_path"].url != nil else {
 throw MovieError.InvalidPosterPath("Poster path url is invalid")
 }
 */

class MockFirebaseMovieService: IFirebaseMovieService {
    var items = [
        FirebaseMovie(id: "1", tmdb_title: "Sample Movie", tmdb_id: "12345")
    ]
    
    func getAllFirebaseMovies() -> Promise<[FirebaseMovie]> {
        return Promise(value: items)
    }
    func getDatabaseReference() -> DatabaseReference {
        return DatabaseReference()
    }
}
