//
//  HomeViewController.swift
//  cinego
//
//  Created by Joshua Orozco on 7/25/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class HomeViewController: UIViewController {
    
    var homePageViewModel: HomePageViewModel! {
        didSet { homePageViewModel.delegate = self }
    }
    
    @IBOutlet weak var homeBannerSlider: ImageSlider!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePageViewModel.fetchAllCinemas()
        homePageViewModel.fetchCinemaMovies()
        homePageViewModel.fetchUpcomingMovies()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + homePageViewModel.cinemaMovies.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageMovieSectionsTableViewCell", for: indexPath) as! HomePageMovieSectionsTableViewCell
        
        // this cell has collection view.
        cell.movieCollectionView.dataSource = cell
        cell.movieCollectionView.delegate = cell
        
        
        // UPCOMING MOVIES
        if indexPath.section == 0 {
            cell.sectionTitleLabel.text = "UPCOMING MOVIES"
            cell.movies = homePageViewModel.upcomingMovies
            return cell
        }
        
        // MOVIES GROUPED BY CINEMA
        if indexPath.section > 0 {
            let cinema = homePageViewModel.cinemaMovies[indexPath.section - 1].0 // 0 -> Cinema
            let movies = homePageViewModel.cinemaMovies[indexPath.section - 1].1 // 1 -> Movie
            cell.sectionTitleLabel.text = cinema.name.uppercased()
            cell.movies = movies
            return cell
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}


extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // to MOVIE DETAILS PAGE
        if segue.identifier == "openMovieDetailsFromHomepage" {
            let destinationVC = segue.destination as! MovieDetailsViewController
            let cell = sender as! MovieCollectionViewCell
            destinationVC.viewModel.movie = cell.movie
        }
    }
}


extension HomeViewController: HomePageViewModelDelegate {
    func cinemasRetrieved(_ cinemas: [Cinema]) {
        // nothing here
    }
    func cinemaMoviesRetrieved(_ cinemaMovies: [(Cinema, [Movie])]) {
        tableView.reloadData()
    }
    func upcomingMoviesRetrieved(_ upcomingMovies: [Movie]) {
        tableView.reloadData()
    }
    func errorProduced(_ error: Error) {
        print(error.localizedDescription)
    }
}

