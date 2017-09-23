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
    var cinemas = [Cinema]()
    
    var homePageViewModel: HomePageViewModel!
    
    @IBOutlet weak var homeBannerSlider: ImageSlider!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homePageViewModel.fetchCinemaMovies()
        homePageViewModel.fetchAllCinemas()
        homePageViewModel.fetchUpcomingMovies()
    }
    
    // loads the home page banner slider
    func loadHomeBannerSlider() {
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
            let movie = cell.movie
//            let firebaseService = FirebaseService()
//            let tmdbService = TMDBMovieService()
//            let movieService = MovieService(tmdbMovieService: tmdbService, firebaseMovieService: firebaseService)
//            let cinemaService = CinemaService()
            //let movieSessionService = MovieSessionService(movieService: movieService, cinemaService: cinemaService)
            //let movieDetailsViewModel = MovieDetailsViewModel(destinationVC, movieSessionService: movieSessionService, movieService: movieService)
            
            destinationVC.movie = movie
            //destinationVC.movieDetailsViewModel = movieDetailsViewModel
        }
    }
}

extension HomeViewController: HomePageViewModelDelegate {
    func cinemasRetrieved(_ cinemas: [Cinema]) {
        self.cinemas = cinemas
        loadHomeBannerSlider()
    }
    func cinemaMoviesRetrieved(_ cinemaMovies: [(Cinema, [Movie])]) {
        self.cinemaMovies = cinemaMovies
        tableView.reloadData()
    }
    func upcomingMoviesRetrieved(_ upcomingMovies: [Movie]) {
        self.upcomingMovies = upcomingMovies
        tableView.reloadData()
    }
    func errorProduced(_ message: String) {
        
    }
}

