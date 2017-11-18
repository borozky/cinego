//
//  MovieSessionServiceTests.swift
//  cinego
//
//  Created by Josh MacDev on 22/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import XCTest
import PromiseKit
import Firebase
import SwiftyJSON
@testable import cinego

class MovieSessionServiceTests: XCTestCase {
    
    var movieSessionService: IMovieSessionService!
    var movieService: IMovieService!
    var cinemaService: ICinemaService!
    var firebaseMovieSessionService: IFirebaseMovieSessionService!
    
    override func setUp() {
        super.setUp()
        
        self.movieService = MockMovieService()
        self.cinemaService = MockCinemaService()
        self.firebaseMovieSessionService = MockFirebaseMovieSessionService()
        self.movieSessionService = MovieSessionService(movieService: movieService, cinemaService: cinemaService, firebaseMovieSessionService: firebaseMovieSessionService)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_movieSessions() {
        // TODO: ...
    }
    
}




