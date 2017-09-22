//
//  HomeViewController.swift
//  cinego
//
//  Created by Joshua Orozco on 7/25/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    // cache movie information here
    var cinemaMovies: [(Cinema, [Movie])] = []
    var upcomingMovies: [Movie] = []
    
    var homePageViewModel: HomePageViewModel!
    
    @IBOutlet weak var homeBannerSlider: ImageSlider!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homePageViewModel.fetchCinemaMovies()
        homePageViewModel.fetchAllCinemas()
        homePageViewModel.fetchUpcomingMovies()
        
        loadHomeBannerSlider()
    }
    
    // loads the home page banner slider
    private func loadHomeBannerSlider() {
        let cinemas = getAllCinemas()
        if cinemas.count > 0 {
            for cinema in cinemas {
                if cinema.images.count > 0 {
                    homeBannerSlider.addImage(UIImage(imageLiteralResourceName: cinema.images[0]))
                }
            }
        }
            
        // default image
        else {
            homeBannerSlider.addImage(#imageLiteral(resourceName: "cinema-image3"))
        }
    }
    
    public func getAllCinemas() -> [Cinema] {
        return CinemaRepository().getAllCinemas()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + cinemaMovies.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageMovieSectionsTableViewCell", for: indexPath) as! HomePageMovieSectionsTableViewCell
        
        // this cell contains a collection view
        cell.movieCollectionView.dataSource = cell
        cell.movieCollectionView.delegate = cell
        
        if indexPath.section == 0 {
            cell.sectionTitleLabel.text = "Upcoming Movies"
            cell.movies = upcomingMovies
            return cell
        }
        
        if indexPath.section > 0 {
            let cinema = cinemaMovies[indexPath.section - 1].0
            let movies = cinemaMovies[indexPath.section - 1].1
            
            cell.sectionTitleLabel.text = cinema.name
            cell.movies = movies
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}


extension HomeViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // to Movie Details Page
        if segue.identifier == "openMovieDetailsFromHomepage" {
            let destinationVC = segue.destination as! MovieDetailsViewController
            let cell = sender as! MovieCollectionViewCell
            let container = SimpleIOCContainer.instance
            let movieSessionRepository = container.resolve(IMovieSessionRepository.self)
            let movieSessions = movieSessionRepository?.getMovieSessions(byMovie: cell.movie) ?? []
            let movie = cell.movie
            
            destinationVC.movie = movie
            destinationVC.movieSessionRepository = movieSessionRepository
            destinationVC.cartRepository = container.resolve(ICartRepository.self)
            destinationVC.movieSessions = movieSessions
        }
        
    }
    
    
}

extension HomeViewController: HomePageViewModelDelegate {
    func cinemasRetrieved(_ cinemas: [Cinema]) {
        
    }
    func cinemaMoviesRetrieved(_ cinemaMovies: [(Cinema, [Movie])]) {
        print("SUNSHINE MOVIES", cinemaMovies[3].1.count)
        for movie in cinemaMovies[3].1 {
            print("\(movie.title) - \(movie.images[0])")
        }
        self.cinemaMovies = cinemaMovies
        tableView.reloadData()
    }
    func upcomingMoviesRetrieved(_ upcomingMovies: [Movie]) {
        print("UPCOMING MOVIES", upcomingMovies.count)
        self.upcomingMovies = upcomingMovies
        tableView.reloadData()
    }
    func errorProduced(_ message: String) {
        
    }
}

//        MovieService().getAllMovies().then { movies -> Void in
//            print("MOVIES")
//            print("NUMBER OF MOVIES", movies.count)
//            movies.forEach {
//                print("MOVIE POSTER", $0.images[0])
//            }
//            print("END MOVIES")
//            }.catch { error in
//                print(error)
//        }
//
//        CinemaService().getAllCinemas().then { cinemas -> Void in
//            print("CINEMAS", cinemas)
//            }.catch { error in
//                print(error)
//        }

//        MovieSessionService(movieService: MovieService(), cinemaService: CinemaService())
//        .getAllMovieSessionFromFirebase().then { movieSessions -> Void in
//            print("MOVIESESSIONS", Array(movieSessions))
//        }.catch { error in
//            print(error)
//        }
//        MovieSessionService(movieService: MovieService(), cinemaService: CinemaService()).getAllMovieSessions().then { movieSessions -> Void in
//            for movieSession in movieSessions {
//                print("MOVIE SESSION: \(movieSession.id), \(movieSession.startTime)")
//            }
//        }.catch { error in
//            print(error)
//        }


//        MovieService().getAllMovies(byIds: [271110,27110]).then { movies -> Void in
//            print("MOVIES", movies)
//        }.catch { error in
//            print(error)
//        }

//        MovieSessionService(movieService: MovieService(), cinemaService: CinemaService())
//            .getMovieSessions(byMovieId: 271110).then { movieSessions -> Void in
//            print(movieSessions)
//        }.asVoid()









