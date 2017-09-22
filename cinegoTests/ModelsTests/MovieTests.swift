//
//  MovieTests.swift
//  cinego
//
//  Created by Josh MacDev on 22/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import XCTest
import Firebase
import SwiftyJSON
@testable import cinego

class MovieTests: XCTestCase {

    var sampleJSON: JSON!
    var sampleMovieKV: [String: String] = [
        "id": "271110",
        "title" : "Captain America: Civil War",
        "runtime" : "146",
        "release_date": "2016-04-26",
        "overview": "Lorem ipsum",
        "poster_path": "http://example.com/"
    ]
    
    override func setUp() {
        super.setUp()
        sampleJSON = JSON(sampleMovieKV)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_movieJSON_ConvertedIntoMovieEntity() throws {
        let movie = try Movie(json: self.sampleJSON)

        XCTAssertEqual(movie.id, sampleMovieKV["id"])
        XCTAssertEqual(movie.title, sampleMovieKV["title"])
        XCTAssertEqual(String(movie.duration), sampleMovieKV["runtime"])
        XCTAssertEqual(movie.details, sampleMovieKV["overview"])
        XCTAssertEqual(movie.images.count, 1)
        XCTAssertEqual(movie.images[0], sampleMovieKV["poster_path"])
    }
    
    func test_InvalidMovieJSON_NotConvertedIntoMovieEntity() throws {
        let invalidMovieJSON = JSON([:])
        XCTAssertThrowsError( try(Movie(json: invalidMovieJSON)) )
    }
    
}
