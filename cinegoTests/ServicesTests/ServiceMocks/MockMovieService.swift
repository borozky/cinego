//
//  MockMovieService.swift
//  cinego
//
//  Created by Josh MacDev on 25/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import PromiseKit
@testable import cinego

class MockMovieService: IMovieService {
    var movies: [Movie] = [
        Movie(id: "1",
              title: "Alien Covenant",
              releaseDate: "19 May 2017",
              duration: 122,
              details: "Bound for a remote planet on the far side of the galaxy, the crew of the colony ship 'Covenant' discovers what is thought to be an uncharted paradise, but is actually a dark, dangerous world – which has its sole inhabitant the 'synthetic', David, survivor of the doomed Prometheus expedition.",
              contentRating: .MA15_PLUS,
              images: ["alien_covenant"]),
        Movie(id: "2",
              title: "Baby Driver",
              releaseDate: "11 March 2017",
              duration: 113,
              details: "After being coerced into working for a crime boss, a young getaway driver finds himself taking part in a heist doomed to fail.",
              contentRating: .MA15_PLUS,
              images: ["baby_driver"]),
        Movie(id: "3",
              title: "Boyka: Undisputed IV",
              releaseDate: "22 September 2017",
              duration: 87,
              details: "In the fourth installment of the fighting franchise, Boyka is shooting for the big leagues when an accidental death in the ring makes him question everything he stands for. When he finds out the wife of the man he accidentally killed is in trouble, Boyka offers to fight in a series of impossible battles to free her from a life of servitude",
              contentRating: .PG,
              images: ["boyka_undisputed_4"]),
        Movie (id: "4",
               title: "Dawn of the Planet of the Apes",
               releaseDate: "21 July 2017",
               duration: 90,
               details: "A group of scientists in San Francisco struggle to stay alive in the aftermath of a plague that is wiping out humanity, while Caesar tries to maintain dominance over his community of intelligent apes.",
               contentRating: .MA15_PLUS,
               images: ["dawn_of_the_planet_of_the_apes"]),
        Movie (id: "5",
               title: "Despicable Me 3",
               releaseDate: "1 July 2016" ,
               duration: 128,
               details: "Gru and his wife Lucy must stop former '80s child star Balthazar Bratt from achieving world domination.",
               contentRating: .G,
               images: ["despicable_me_3"]),
        Movie (id: "6",
               title: "Doctor Strange",
               releaseDate: "1 July 2017",
               duration: 108,
               details: "After his career is destroyed, a brilliant but arrogant surgeon gets a new lease on life when a sorcerer takes him under his wing and trains him to defend the world against evil.",
               contentRating: .PG,
               images: ["doctor_strange"])
    ]
    
    func findMovie(_ id: Int) -> Promise<Movie> {
        let movie = movies.filter { $0.id == String(id) }
        guard movie.count > 0 else {
            return Promise(error: MockError.NotFound)
        }
        return Promise(value: movie.first!)
    }
    
    func getAllMovies() -> Promise<[Movie]> {
        return Promise(value: movies)
    }
    
    func getAllMovies(byIds ids: [Int]) -> Promise<[Movie]> {
        let filtered = movies.filter { movie in
            return ids.contains(Int(movie.id)!)
        }
        guard filtered.count > 0 else {
            return Promise(error: MockError.NotFound)
        }
        return Promise(value: filtered)
    }
}
