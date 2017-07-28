//
//  session.swift
//  cinego
//
//  Created by Joshua Orozco on 7/24/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation


class Show {
    private var id: Int = 0
    private var startTime: String = "YYYY-mm-dd HH:mm:ss Z"
    private var movieId: Int = 0
    
    init(_ id: Int, _ startTime: String, _ movieId: Int) {
        self.id = id
        self.startTime = startTime
        self.movieId = movieId
    }
    
    func getId() -> Int {
        return id
    }
    
    func getStartTime() -> String {
        return startTime
    }
    
    func getMovieId() -> Int {
        return movieId
    }
    
    
    
}
