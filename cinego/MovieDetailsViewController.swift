//
//  MovieDetailsViewController.swift
//  cinego
//
//  Created by Victor Orosco on 28/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    let tableViewCellID = "MovieSessionTableViewCell"
    
    @IBOutlet weak var movieSessionsTableView: UITableView!
    @IBOutlet weak var movieDetailsView: MovieDetailsView!
    
    var viewModel: MovieDetailsViewModel! {
        didSet {
            self.viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsView.movie = viewModel.movie
        let movieId = Int(viewModel.movie.id)!
        viewModel.fetchMovieSessions(byMovieId: movieId)
    }
}


// MARK: Table View
extension MovieDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.movieSessionsByCinema.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(viewModel.movieSessionsByCinema[section].0.name.uppercased()) MOVIE PLAZA THEATER"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieSessionsByCinema[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieSessions = viewModel.movieSessionsByCinema[indexPath.section].1
        let movieSession = movieSessions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        cell.textLabel?.text = humaniseTime(movieSession.startTime)
        cell.detailTextLabel?.text = String(format: "%d seats available", movieSession.cinema.numberOfSeatsOfType(.AVAILABLE))
        return cell
    }
    
    // Helper method: Date to readable time, 
    // eg. Date() -> Mon Aug 28 09:30 am
    private func humaniseTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd MMM hh:mm aa"
        return formatter.string(from: date)
    }
}

// MARK: Segues
extension MovieDetailsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openBookingDetailsFromMovieDetails" {
            let destinationVC = segue.destination as! MovieSessionDetailsVC
            let indexPath = self.movieSessionsTableView.indexPathForSelectedRow!
            let selectedSession = viewModel.movieSessionsByCinema[indexPath.section].1[indexPath.row]
            
            destinationVC.viewModel.movieSession = selectedSession
            destinationVC.delegate = self
            
            let foundPair = MovieDetailsViewModel.selectedSeatsForSessions.filter{ $0.0.id == selectedSession.id }
            
            if foundPair.count == 0  {
                destinationVC.viewModel.selectedSeats = []
            } else {
                destinationVC.viewModel.selectedSeats = foundPair.first!.1
            }
        }
    }
    
}

extension MovieDetailsViewController: MovieSessionDetailsVCDelegate {
    func didUpdateSeats(_ movieSession: MovieSession, _ selectedSeats: [Seat]) {
        let index = MovieDetailsViewModel.selectedSeatsForSessions.index(where: {
            $0.0.id == movieSession.id
        })
        
        if index != nil {
            MovieDetailsViewModel.selectedSeatsForSessions[index!].1 = selectedSeats
        } else {
            MovieDetailsViewModel.selectedSeatsForSessions.append((movieSession, selectedSeats))
        }
    }
}

extension MovieDetailsViewController: MovieDetailsViewModelDelegate {
    func movieSessionsRetrieved(_ movieSessions: [MovieSession]) {
        self.movieSessionsTableView.reloadData()
    }
    
    func movieDetailsRetrieved(_ movie: Movie) {
        movieDetailsView?.movie = movie
    }
    
    func errorProduced() {
    }
}
