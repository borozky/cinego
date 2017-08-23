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
    
    
    let tableViewCellID = "MovieSessionTableViewCell"
    @IBOutlet weak var movieBannerImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieAudienceTypeLabel: UILabel!
    @IBOutlet weak var movieSessionsTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovie()
        setupMovieSessions()
    }

    
    private func setupMovie(){
        movieBannerImageView.image = UIImage(imageLiteralResourceName: movie.images[0])
        movieTitleLabel.text =  movie.title
        movieReleaseDateLabel.text = "Released: \(movie.releaseDate)"
        movieDurationLabel.text = "Duration \(String(movie.duration)) minutes"
        movieAudienceTypeLabel.text = movie.contentRating.rawValue
        
    }
    
    private func setupMovieSessions(){
        movieSessions = movieSessionRepository!.getMovieSessions(byMovie: movie!)
    }
    
}


extension MovieDetailsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "SESSIONS"
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSessions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieSession = movieSessions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        cell.textLabel?.text = humaniseTime(movieSession.startTime)
        cell.detailTextLabel?.text = movieSession.cinema.name
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
            
            destinationVC.movieSession = selectedSession
            destinationVC.movie = movie!
            destinationVC.cartRepository = container.resolve(ICartRepository.self)
            destinationVC.delegate = self
        }
        
        // to Movie Additional Details
        else if segue.identifier == "openMovieAdditionalDetailsFromMovieDetailsPage" {
            let movieAdditionalDetailsTableVC = segue.destination as! MovieAdditionalDetailsTableVC
            movieAdditionalDetailsTableVC.movie = movie!
        }
    }
    
}


extension MovieDetailsViewController: BookingDetailsVCDelegate {
    func didBook(_ cartItem: CartItem) {
        print("Did book!")
    }
}
