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
        
        
        var movie = Movie(title: "Alien Covenant", releaseDate: "19 May 2017", duration: 122, sessions: [], images: ["alien_covenant"])
        movie.id = 1
        movie.details = "Bound for a remote planet on the far side of the galaxy, the crew of the colony ship 'Covenant' discovers what is thought to be an uncharted paradise, but is actually a dark, dangerous world – which has its sole inhabitant the 'synthetic', David, survivor of the doomed Prometheus expedition."
        movies.append(movie)
        
        
        movie = Movie(title: "Baby Driver", releaseDate: "11 March 2017", duration: 113, sessions: [], images: ["baby_driver"])
        movie.id = 2
        movie.details = "After being coerced into working for a crime boss, a young getaway driver finds himself taking part in a heist doomed to fail."
        movies.append(movie)
        
        
        movie = Movie(title: "Boyka: Undisputed IV", releaseDate: "22 September 2017", duration: 87, sessions: [], images: ["boyka_undisputed_4"])
        movie.id = 3
        movie.details = "In the fourth installment of the fighting franchise, Boyka is shooting for the big leagues when an accidental death in the ring makes him question everything he stands for. When he finds out the wife of the man he accidentally killed is in trouble, Boyka offers to fight in a series of impossible battles to free her from a life of servitude"
        movies.append(movie)
        
        
        movie = Movie (title: "Dawn of the Planet of the Apes", releaseDate: "21 July 2017", duration: 90, sessions: [], images: ["dawn_of_the_planet_of_the_apes"])
        movie.id = 4
        movie.details = "A group of scientists in San Francisco struggle to stay alive in the aftermath of a plague that is wiping out humanity, while Caesar tries to maintain dominance over his community of intelligent apes."
        movies.append(movie)

        
        movie = Movie (title: "Despicable Me 3", releaseDate: "1 July 2016" , duration: 128, sessions: [], images: ["despicable_me_3"])
        movie.id = 5
        movie.details = "Gru and his wife Lucy must stop former '80s child star Balthazar Bratt from achieving world domination."
        movies.append(movie)
        
        
        movie = Movie (title: "Doctor Strange", releaseDate: "1 July 2017" , duration: 108, sessions: [], images: ["doctor_strange"])
        movie.id = 6
        movie.details = "After his career is destroyed, a brilliant but arrogant surgeon gets a new lease on life when a sorcerer takes him under his wing and trains him to defend the world against evil."
        movies.append(movie)
        
        
        movie = Movie (title: "Hancock", releaseDate: "13 July 2017" , duration: 108, sessions: [], images: ["hancock"])
        movie.id = 7
        movie.details = "Hancock is a down-and-out superhero who's forced to employ a PR expert to help repair his image when the public grows weary of all the damage he's inflicted during his lifesaving heroics. The agent's idea of imprisoning the antihero to make the world miss him proves successful, but will Hancock stick to his new sense of purpose or slip back into old habits?"
        movies.append(movie)
        
        
        movie = Movie (title: "Harry Potter and the Philosopher Stone", releaseDate: "1 July 2015" , duration: 120, sessions: [], images: ["harry_potter_and_the_philosopher_stone"])
        movie.id = 8
        movie.details = "Harry Potter has lived under the stairs at his aunt and uncle's house his whole life. But on his 11th birthday, he learns he's a powerful wizard -- with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school's kindly headmaster, Harry uncovers the truth about his parents' deaths -- and about the villain who's to blame."
        movies.append(movie)
        
        
        movie = Movie (title: "I am Legend", releaseDate: "1 October 2017" , duration: 120, sessions: [], images: ["i_am_legend"])
        movie.id = 9
        movie.details = "Robert Neville is a scientist who was unable to stop the spread of the terrible virus that was incurable and man-made. Immune, Neville is now the last human survivor in what is left of New York City and perhaps the world. For three years, Neville has faithfully sent out daily radio messages, desperate to find any other survivors who might be out there. But he is not alone."
        movies.append(movie)
        
        
        movie = Movie (title: "Ice Age", releaseDate: "16 October 2017" , duration: 98, sessions: [], images: ["ice_age"])
        movie.id = 10
        movie.details = "With the impending ice age almost upon them, a mismatched trio of prehistoric critters – Manny the woolly mammoth, Diego the saber-toothed tiger and Sid the giant sloth – find an orphaned infant and decide to return it to its human parents. Along the way, the unlikely allies become friends but, when enemies attack, their quest takes on far nobler aims."
        movies.append(movie)
        
        
        movie = Movie (title: "kingsman the Secret Service", releaseDate: "22 October 2017" , duration: 97, sessions: [], images: ["kingsman_the_secret_service"])
        movie.id = 11
        movie.details = "The story of a super-secret spy organization that recruits an unrefined but promising street kid into the agency's ultra-competitive training program just as a global threat emerges from a twisted tech genius."
        movies.append(movie)
        
        
        
        movie = Movie (title: "Lucy", releaseDate: "22 December 2016" , duration: 107, sessions: [], images: ["lucy"])
        movie.id = 12
        movie.details = "A woman, accidentally caught in a dark deal, turns the tables on her captors and transforms into a merciless warrior evolved beyond human logic."
        movies.append(movie)
        
        
        movie = Movie (title: "Minions", releaseDate: "12 December 2017" , duration: 107, sessions: [], images: ["minions"])
        movie.id = 13
        movie.details = "Minions Stuart, Kevin and Bob are recruited by Scarlet Overkill, a super-villain who, alongside her inventor husband Herb, hatches a plot to take over the world."
        movies.append(movie)
        
        
        movie = Movie (title: "Miss Peregrines Home for Peculiar Children", releaseDate: "9 November 2017" , duration: 100, sessions: [], images: ["miss_peregrines_home_for_peculiar_children"])
        movie.id = 14
        movie.details = "A teenager finds himself transported to an island where he must help protect a group of orphans with special powers from creatures intent on destroying them."
        movies.append(movie)
        
        
        
        movie = Movie (title: "Power Rangers", releaseDate: "9 March 2017" , duration: 110, sessions: [], images: ["power_rangers"])
        movie.id = 15
        movie.details = "Saban's Power Rangers follows five ordinary teens who must become something extraordinary when they learn that their small town of Angel Grove — and the world — is on the verge of being obliterated by an alien threat. Chosen by destiny, our heroes quickly discover they are the only ones who can save the planet. But to do so, they will have to overcome their real-life issues and before it’s too late, band together as the Power Rangers."
        movies.append(movie)
        
        
        movie = Movie (title: "San Andreas", releaseDate: "9 August 2017" , duration: 88, sessions: [], images: ["san_andreas"])
        movie.id = 16
        movie.details = "In the aftermath of a massive earthquake in California, a rescue-chopper pilot makes a dangerous journey across the state in order to rescue his estranged daughter."
        movies.append(movie)
        
        
        movie = Movie (title: "Sing", releaseDate: "19 August 2016" , duration: 118, sessions: [], images: ["sing"])
        movie.id = 17
        movie.details = "A koala named Buster recruits his best friend to help him drum up business for his theater by hosting a singing competition."
        movies.append(movie)
        
        
        movie = Movie (title: "Spiderman Homecoming", releaseDate: "15 Janurary 2016" , duration: 98, sessions: [], images: ["spiderman_homecoming"])
        movie.id = 18
        movie.details = "Following the events of Captain America: Civil War, Peter Parker, with the help of his mentor Tony Stark, tries to balance his life as an ordinary high school student in Queens, New York City, with fighting crime as his superhero alter ego Spider-Man as a new threat, the Vulture, emerges."
        movies.append(movie)
        
        
        movie = Movie (title: "Taxi Driver", releaseDate: "19 Janurary 2017" , duration: 115, sessions: [], images: ["taxi_driver"])
        movie.id = 19
        movie.details = "A mentally unstable Vietnam War veteran works as a night-time taxi driver in New York City where the perceived decadence and sleaze feeds his urge for violent action, attempting to save a preadolescent prostitute in the process."
        movies.append(movie)
        
        
        movie = Movie (title: "Terminator Genisys", releaseDate: "13 June 2017" , duration: 110, sessions: [], images: ["terminator_genisys"])
        movie.id = 20
        movie.details = "The year is 2029. John Connor, leader of the resistance continues the war against the machines. At the Los Angeles offensive, John's fears of the unknown future begin to emerge when TECOM spies reveal a new plot by SkyNet that will attack him from both fronts; past and future, and will ultimately change warfare forever."
        movies.append(movie)
        
        
        
        return movies
    }
    
    
    
    func getMovies(byTitle title: String) -> [Movie] {
        var results: [Movie] = []
        for movie in getUpcomingMovies() {
            if movie.title.lowercased() == title.lowercased() {
                results.append(movie)
            }
        }
        return results
    }
    
    
    
    func getMovie(byId id: Int) -> Movie? {
        let movies = getUpcomingMovies()
        for movie in movies {
            if movie.id == id {
                return movie
            }
        }
        return nil
    }
    
    
    
    func getMovies(byCinema cinema: Cinema) -> [Movie] {
        return getUpcomingMovies()
    }
    
    
    
    func getUpcomingMovies(fromCinema cinema: Cinema) -> [Movie] {
        return getUpcomingMovies()
    }
    
    
    
    func searchMovie(byKeyword keyword: String) -> [Movie] {
        return getUpcomingMovies()
    }
    
}
