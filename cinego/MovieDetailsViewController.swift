//
//  MovieDetailsViewController.swift
//  cinego
//
//  Created by Victor Orosco on 28/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieSessionsTableView: UITableView!
    @IBOutlet weak var movieDetailsView: MovieDetailsView!
    
    static var selectedSeatsForSessions: [(MovieSession, [Seat])] = []
    
    
    var movieSessionRepository: IMovieSessionRepository!
    var cartRepository: ICartRepository!
    var movie: Movie!
    var movieSessions: [MovieSession] = []
    var movieSessionsByCinema: [(Cinema, [MovieSession])] {
        var _movieSessionsByCinema: [(Cinema, [MovieSession])] = []
        let cinemas = movieSessions.map {$0.cinema}
        var _cinemas: [Cinema] = []
        for cinema in cinemas {
            let exists = _cinemas.contains(where: { $0.id == cinema.id })
            if exists {
                continue
            }
            _cinemas.append(cinema)
        }
        
        for cinema in _cinemas {
            let sessions = movieSessions.filter{ $0.cinema.id == cinema.id }
            _movieSessionsByCinema.append((cinema, sessions))
        }
        
        return _movieSessionsByCinema
    }
    
    
    let tableViewCellID = "MovieSessionTableViewCell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsView.movie = movie
    }
    
}


extension MovieDetailsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieSessionsByCinema.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(movieSessionsByCinema[section].0.name.uppercased()) MOVIE PLAZA THEATER"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSessionsByCinema[section].1.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieSessions = movieSessionsByCinema[indexPath.section].1
        let movieSession = movieSessions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        cell.textLabel?.text = humaniseTime(movieSession.startTime)
        cell.detailTextLabel?.text = String(format: "%d seats available", movieSession.cinema.numberOfSeatsOfType(.AVAILABLE))
        
        if cartRepository.findCartItem(byMovieSession: movieSession) != nil {
            cell.isUserInteractionEnabled = false
            cell.accessoryType = .checkmark
            cell.detailTextLabel?.text = String(format: "%d seats available (added to cart)",
                                                movieSession.cinema.numberOfSeatsOfType(.AVAILABLE))
        }
        
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


extension MovieDetailsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // to Movie Session details (BookingDetailsVC)
        if segue.identifier == "openBookingDetailsFromMovieDetails" {
            let destinationVC = segue.destination as! BookingDetailsVC
            let indexPath = self.movieSessionsTableView.indexPathForSelectedRow!
            let selectedSession = movieSessionsByCinema[indexPath.section].1[indexPath.row]
            destinationVC.movieSession = selectedSession
            destinationVC.delegate = self
            
            let foundPair = MovieDetailsViewController.selectedSeatsForSessions.filter{ $0.0.id == selectedSession.id }
            
            if foundPair.count == 0  {
                destinationVC.selectedSeats = []
            } else {
                destinationVC.selectedSeats = foundPair.first!.1
            }
            
        }
    }
    
}

extension MovieDetailsViewController: BookingDetailsVCDelegate {
    func didUpdateSeats(_ movieSession: MovieSession, _ selectedSeats: [Seat]) {
        let index = MovieDetailsViewController.selectedSeatsForSessions.index(where: {
            $0.0.id == movieSession.id
        })
        
        if index != nil {
            MovieDetailsViewController.selectedSeatsForSessions[index!].1 = selectedSeats
        } else {
            MovieDetailsViewController.selectedSeatsForSessions.append((movieSession, selectedSeats))
        }
    }
}
