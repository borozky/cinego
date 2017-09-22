//
//  movie.swift
//  cinego
//
//  Created by Jiahong He on 24/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movie {
    let id: String
    let title: String
    let releaseDate: String
    let duration: Int
    let details: String
    let contentRating: ContentRating
    let images: [String]
}

enum MovieError: Error {
    case InvalidPosterPath(String)
}

extension Movie {
    init(json: JSON) throws {
        let movie_id = json["id"].rawString()!
        let movie_title = json["title"].rawString()!
        let movie_release_date = json["release_date"].rawString()!
        let movie_duration = json["runtime"].intValue
        let movie_details = json["overview"].rawString()!
        let movie_poster = json["poster_path"].rawString()
        guard json["poster_path"].url != nil else {
            throw MovieError.InvalidPosterPath("Poster path url is invalid")
        }
        
        self.init(
            id: movie_id,
            title: movie_title,
            releaseDate: movie_release_date,
            duration: movie_duration,
            details: movie_details,
            contentRating: ContentRating.NOT_RATED,
            images: movie_poster != nil ? [movie_poster!] : []
        )
        
    }
}
