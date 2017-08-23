//
//  movie.swift
//  cinego
//
//  Created by Jiahong He on 24/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

//class Movie {
//    
//    var id: Int? = nil
//    var title: String = ""
//    var releaseDate: String = ""
//    var duration: Int = 0
//    var details: String? = ""
//    var audienceType: String? = ""
//    var contentRating: ContentRating = .NOT_RATED
//    var sessions: [MovieSession] = []
//    var images: [String] = []
//    
//    init(title: String = "", releaseDate: String = "", duration: Int = 0, sessions: [MovieSession] = [], images: [String] = []){
//        self.title = title
//        self.releaseDate = releaseDate
//        self.duration = duration
//        self.sessions = sessions
//        self.images = images
//    }
//    
//    func addSession(_ sessions: MovieSession){
//        self.sessions.append(sessions)
//    }
//}

struct Movie {
    let id: String
    let title: String
    let releaseDate: String
    let duration: Int
    let details: String
    let contentRating: ContentRating
    let images: [String]
}
