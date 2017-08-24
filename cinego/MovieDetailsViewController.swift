//
//  MovieDetailsViewController.swift
//  cinego
//
//  Created by Victor Orosco on 28/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // TODO: Refactor into ViewModels
    var movieSessionRepository: IMovieSessionRepository!
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
    @IBOutlet weak var movieBackgroundImageView: UIImageView!
    @IBOutlet weak var movieBannerImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieAudienceTypeLabel: UILabel!
    @IBOutlet weak var movieSessionsTableView: UITableView!
    @IBOutlet weak var movieExcerptLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovie()
    }

    
    private func setupMovie(){
        movieBannerImageView.image = UIImage(imageLiteralResourceName: movie.images[0])
        movieTitleLabel.text =  movie.title
        movieReleaseDateLabel.text = "Released: \(movie.releaseDate)"
        movieDurationLabel.text = "Duration \(String(movie.duration)) minutes"
        movieAudienceTypeLabel.text = movie.contentRating.rawValue
        movieExcerptLabel.text = movie.details
        movieBackgroundImageView.image = UIImage(imageLiteralResourceName: movie.images[0])
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
            let container = SimpleIOCContainer.instance
            let destinationVC = segue.destination as! BookingDetailsVC
            let indexPath = self.movieSessionsTableView.indexPathForSelectedRow
            let selectedSession = movieSessions[(indexPath?.row)!]
            let cartRepository: ICartRepository = container.resolve(ICartRepository.self)!
            
            destinationVC.movieSession = selectedSession
            destinationVC.movie = movie!
            destinationVC.cartRepository = cartRepository
            destinationVC.delegate = self
            destinationVC.cartItem = cartRepository.findCartItem(byMovieSession: selectedSession)
        }
    }
    
}


extension MovieDetailsViewController: BookingDetailsVCDelegate {
    func didBook(_ cartItem: CartItem) {
        print("Did book!")
    }
}
