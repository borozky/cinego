//
//  HomePageViewModelTests.swift
//  cinego
//
//  Created by 何家红 on 4/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import XCTest
@testable import cinego


class HomePageViewModelTests: XCTestCase {
    
    var cinemaRepository: ICinemaRepository = CinemaRepository()
    var movieRepository: IMovieRepository = MovieRepository()
    var homePageViewModel: HomePageViewModel!
    override func setUp() {
        super.setUp()
        cinemaRepository = CinemaRepository()
        movieRepository = MovieRepository()
        homePageViewModel = HomePageViewModel(movieRepository, cinemaRepository)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testExample() {
    }
    
    
    func testPerformanceExample() {
        self.measure {
           
        }
    }
    
    
    func testGetAllCinemas(){
        let numCinemas = cinemaRepository.getAllCinemas().count
        let numCinemasInVM = homePageViewModel.getAllCinemas().count
        XCTAssertEqual(numCinemas, numCinemasInVM)
    }
    
    
    func testGetUpcomingMovies(){
        let numUpcomingMovies = movieRepository.getUpcomingMovies().count
        let numUpcomingMoviesInVM = homePageViewModel.getUpcomingMovies().count
        XCTAssertEqual(numUpcomingMovies, numUpcomingMoviesInVM)
    }
    
    func testGetCinemaMovies (){
        
    }
}
