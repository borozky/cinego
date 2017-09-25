//
//  MovieServiceTests.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import XCTest
import PromiseKit
import SwiftyJSON
import Firebase
@testable import cinego

class MovieServiceTests: XCTestCase {
    
    var movieService: IMovieService!
    var tmdbService: ITMDBMovieService!
    var firebaseService: IFirebaseMovieService!
    
    override func setUp() {
        super.setUp()
        
        self.tmdbService = MockTMDBService()
        self.firebaseService = MockFirebaseMovieService()
        self.movieService = MovieService(tmdbMovieService: tmdbService, firebaseMovieService: firebaseService)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_existingMovies_IsNotNil(){
        let ex = expectation(description: "")
        let id = 12345
        
        self.movieService.findMovie(id).then { movie -> Void in
            XCTAssertNotNil(movie)
        }.catch { error in
            XCTFail("Movie \(String(id)) should exists")
        }.always {
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_nonExistingMovies_GivesEmptyResult(){
        let ex = expectation(description: "")
        let id = 1234
        
        self.movieService.findMovie(id).then { movie -> Void in
            XCTFail("Movie \(String(id)) should not exist")
        }.catch { error in
            XCTAssert(true)
        }.always {
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
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
enum MockTMDBError: Error {
    case NotFound(String)
}

class MockTMDBService: ITMDBMovieService {
    var items: [[String: Any]] = [
        [
            "id" : "12345",
            "title": "Sample Movie",
            "release_date": "2016-04-25",
            "runtime": "124",
            "overview": "Lorem ipsum",
            "poster_path": "http://example.com"
        ]
    ]
    
    
    func findTMDBMovie(_ id: Int) -> Promise<SwiftyJSON.JSON> {
        return Promise { fulfill, reject in
            let results = items.filter { item in
                let itemID = item["id"] as! String
                return itemID == String(id)
            }
            guard results.count > 0 else {
                reject(MockTMDBError.NotFound("Movie not found"))
                return
            }
            
            fulfill(JSON(results.first!))
        }
    }
}
