//
//  HomeViewController.swift
//  cinego
//
//  Created by Joshua Orozco on 7/25/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homePageViewModel: HomePageViewModel!
    var cinemaMovies: [(Cinema, [Movie])] = []
    var upcomingMovies: [Movie] = []
    
    @IBOutlet weak var homeBannerSlider: ImageSlider!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHomeBannerSlider()
        upcomingMovies = homePageViewModel.getUpcomingMovies()
        cinemaMovies = homePageViewModel.getCinemaMovies()
    }
    
    // loads the home page banner slider
    private func loadHomeBannerSlider() {
        let cinemas = homePageViewModel.getAllCinemas()
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
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + homePageViewModel.getCinemaMovies().count
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
            cell.sectionTitleLabel.text = cinemaMovies[indexPath.section - 1].0.name
            cell.movies = cinemaMovies[indexPath.section - 1].1
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






