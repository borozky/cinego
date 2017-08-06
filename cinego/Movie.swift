//
//  movie.swift
//  cinego
//
//  Created by 何家红 on 24/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class Movie {
    
    var id: Int? = nil
    var title: String = ""
    var releaseDate: String = ""
    var duration: Int = 0
    var sessions: [MovieSession] = []
    var images: [String] = []
    
    init(title: String = "", releaseDate: String = "", duration: Int = 0, sessions: [MovieSession] = [], images: [String] = []){
        self.title = title
        self.releaseDate = releaseDate
        self.duration = duration
        self.sessions = sessions
        self.images = images
    }
    
    func addSession(_ sessions: MovieSession){
        self.sessions.append(sessions)
    }
    
    
    
}
