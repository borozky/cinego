//
//  MovieRepository.swift
//  cinego
//
//  Created by Victor Orosco on 29/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation

class MovieRepository : IMovieRepository {
    
    func getUpcomingMovies() -> [Movie] {
        var movies: [Movie] = []
        
        
        
        var movie: Movie = Movie(title: "Thor: Ragnarok", releaseDate: "2017", duration: 140, sessions: [], images: [])
        movie.id = 1
        movie.audienceType = "PG-13"
        movie.details = "Thor is imprisoned on the other side of the universe and finds himself in a race against time to get back to Asgard to stop Ragnarok, the destruction of his homeworld and the end of Asgardian civilization, at the hands of an all-powerful new threat, the ruthless Hela."
        movies.append(movie)
        
        
        
        movie = Movie(title: "Avengers", releaseDate: "25-04-2017 00:00:00", duration: 143, sessions: [], images: [])
        movie.id = 2
        movie.audienceType = "M"
        movie.details = "When an unexpected enemy emerges and threatens global safety and security, Nick Fury, director of the international peacekeeping agency known as S.H.I.E.L.D., finds himself in need of a team to pull the world back from the brink of disaster. Spanning the globe, a daring recruitment effort begins!"
        movies.append(movie)
        
        
        
        movie = Movie(title: "Gone with the Wind", releaseDate: "30-04-1940 00:00:00", duration: 238, sessions: [], images: [])
        movie.id = 3
        movie.audienceType = "PG"
        movie.details = "An American classic in which a manipulative woman and a roguish man carry on a turbulent love affair in the American south during the Civil War and Reconstruction."
        movies.append(movie)
        
        
        movie = Movie(title: "Crocodile Dundee", releaseDate: "24-10-2017 00:00:00", duration: 97, sessions: [], images: [])
        movie.id = 4
        movie.audienceType = "M"
        movie.details = "When a New York reporter plucks crocodile hunter Dundee from the Australian Outback for a visit to the Big Apple, it's a clash of cultures and a recipe for good-natured comedy as naïve Dundee negotiates the concrete jungle. Dundee proves that his instincts are quite useful in the city and adeptly handles everything from wily muggers to high-society snoots without breaking a sweat."
        movies.append(movie)
        
        
        
        movie = Movie(title: "Spider Man (2002)", releaseDate: "06-06-2002 00:00:00", duration: 121, sessions: [], images: [])
        movie.id = 5
        movie.audienceType = "M"
        movie.details = "After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers."
        movies.append(movie)
        
        
        
        movie = Movie(title: "Oz: The Great and Powerful", releaseDate: "07-03-2013 00:00:00", duration: 140, sessions: [], images: [])
        movie.id = 6
        movie.audienceType = "PG"
        movie.details = "Oscar Diggs, a small-time circus illusionist and con-artist, is whisked from Kansas to the Land of Oz where the inhabitants assume he's the great wizard of prophecy, there to save Oz from the clutches of evil."
        movies.append(movie)
        
        
        
        movie = Movie(title: "Wall-E", releaseDate: "06-18-2008 00:00:00", duration: 98, sessions: [], images: [])
        movie.id = 7
        movie.audienceType = "G"
        movie.details = "WALL·E is the last robot left on an Earth that has been overrun with garbage and all humans have fled to outer space. For 700 years he has continued to try and clean up the mess, but has developed some rather interesting human-like qualities. When a ship arrives with a sleek new type of robot, WALL·E thinks he's finally found a friend and stows away on the ship when it leaves."
        movies.append(movie)
        
        
        
        movie = Movie(title: "Avatar", releaseDate: "25-08-2010 00:00:00", duration: 162, sessions: [], images: [])
        movie.id = 8
        movie.audienceType = "M"
        movie.details = "In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization."
        movies.append(movie)
        
        
        
        movie = Movie(title: "Captain America", releaseDate: "28-07-2011 00:00:00", duration: 124, sessions: [], images: [])
        movie.id = 9
        movie.audienceType = "M"
        movie.details = "Predominantly set during World War II, Steve Rogers is a sickly man from Brooklyn who's transformed into super-soldier Captain America to aid in the war effort. Rogers must stop the Red Skull – Adolf Hitler's ruthless head of weaponry, and the leader of an organization that intends to use a mysterious device of untold powers for world domination."
        movies.append(movie)
        
        
        
        movie = Movie(title: "Transformers", releaseDate: "28-06-2007 00:00:00", duration: 144, sessions: [], images: [])
        movie.id = 10
        movie.audienceType = "M"
        movie.details = "Young teenager, Sam Witwicky becomes involved in the ancient struggle between two extraterrestrial factions of transforming robots – the heroic Autobots and the evil Decepticons. Sam holds the clue to unimaginable power and the Decepticons will stop at nothing to retrieve"
        movies.append(movie)
        

        return movies
    }
    
    
    func getMovies(title: String) -> [Movie] {
        var movies: [Movie] = []
        movies.append(Movie(title: "Movie 1", releaseDate: "2017", duration: 140, sessions: [], images: []))
        movies.append(Movie(title: "Movie 2", releaseDate: "2017", duration: 138, sessions: [], images: []))
        movies.append(Movie(title: "Movie 3", releaseDate: "2017", duration: 160, sessions: [], images: []))
        movies.append(Movie(title: "Movie 4", releaseDate: "2017", duration: 170, sessions: [], images: []))
        movies.append(Movie(title: "Movie 5", releaseDate: "2017", duration: 200, sessions: [], images: []))
        movies.append(Movie(title: "Movie 7", releaseDate: "2017", duration: 150, sessions: [], images: []))
        return movies
    }
    
    
    func getMovie(id: Int) -> Movie {
        return Movie(title: "Movie 1", releaseDate: "12 July 2017", duration: 140, sessions: [], images: [])
    }
    
    
    func getMovies(byCinema: Cinema) -> [Movie] {
        var movies: [Movie] = []
        movies.append(Movie(title: "Movie 1", releaseDate: "2017", duration: 140, sessions: [], images: []))
        movies.append(Movie(title: "Movie 2", releaseDate: "2017", duration: 138, sessions: [], images: []))
        movies.append(Movie(title: "Movie 3", releaseDate: "2017", duration: 160, sessions: [], images: []))
        movies.append(Movie(title: "Movie 4", releaseDate: "2017", duration: 170, sessions: [], images: []))
        movies.append(Movie(title: "Movie 5", releaseDate: "2017", duration: 200, sessions: [], images: []))
        movies.append(Movie(title: "Movie 7", releaseDate: "2017", duration: 150, sessions: [], images: []))
        return movies
    }
    
    
    func getUpcomingMovies(fromCinema cinema: Cinema) -> [Movie] {
        var movies: [Movie] = []
        movies.append(Movie(title: "Movie 1", releaseDate: "2017", duration: 140, sessions: [], images: []))
        movies.append(Movie(title: "Movie 2", releaseDate: "2017", duration: 138, sessions: [], images: []))
        movies.append(Movie(title: "Movie 3", releaseDate: "2017", duration: 160, sessions: [], images: []))
        movies.append(Movie(title: "Movie 4", releaseDate: "2017", duration: 170, sessions: [], images: []))
        movies.append(Movie(title: "Movie 5", releaseDate: "2017", duration: 200, sessions: [], images: []))
        movies.append(Movie(title: "Movie 7", releaseDate: "2017", duration: 150, sessions: [], images: []))
        return movies
    }
    
    func searchMovie(byKeyword keyword: String) -> [Movie] {
        var movies: [Movie] = []
        movies.append(Movie(title: "Movie 1", releaseDate: "2017", duration: 140, sessions: [], images: []))
        movies.append(Movie(title: "Movie 2", releaseDate: "2017", duration: 138, sessions: [], images: []))
        movies.append(Movie(title: "Movie 3", releaseDate: "2017", duration: 160, sessions: [], images: []))
        movies.append(Movie(title: "Movie 4", releaseDate: "2017", duration: 170, sessions: [], images: []))
        movies.append(Movie(title: "Movie 5", releaseDate: "2017", duration: 200, sessions: [], images: []))
        movies.append(Movie(title: "Movie 7", releaseDate: "2017", duration: 150, sessions: [], images: []))
        return movies
    }
    
}
