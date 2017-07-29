//
//  movie.swift
//  cinego
//
//  Created by 何家红 on 24/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class Movie {
    
    var id: Int? {
        get { return self.id }
        set { self.id = newValue }
    }
    
    var title: String {
        get { return self.title }
        set { self.title = newValue }
    }
    
    var releaseDate: String {
        get { return self.releaseDate }
        set { self.releaseDate = newValue }
    }
    
    var duration: Int {
        get { return self.duration }
        set { self.duration = newValue }
    }
    
    var sessions: [MovieSession] {
        get { return self.sessions }
        set { self.sessions = newValue }
    }
    
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
