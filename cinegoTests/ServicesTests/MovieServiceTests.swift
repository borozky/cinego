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
        
        let movieRepo = MovieCoreDataRepository(context: DatabaseController.getContext())
        self.movieService = MovieService(tmdbMovieService: tmdbService, firebaseMovieService: firebaseService, movieRepository: movieRepo)
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


