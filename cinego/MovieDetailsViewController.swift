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
    
    @IBOutlet weak var movieBannerImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieAudienceTypeLabel: UILabel!
    @IBOutlet weak var movieSessionsTableView: UITableView!
    
    var movieSessionRepository: IMovieSessionRepository!
    
    var movie: Movie!
    var movieSessions: [MovieSession] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovie()
        setupMovieSessions2()
    }

    private func setupMovie(){
        movieBannerImageView.image = UIImage(imageLiteralResourceName: movie.images[0])
        movieTitleLabel.text =  movie.title
        movieReleaseDateLabel.text = "Released: \(movie.releaseDate)"
        movieDurationLabel.text = "Duration \(String(movie.duration)) minutes"
        movieAudienceTypeLabel.text = movie?.audienceType
        
    }
    
    private func setupMovieSessions2(){
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
        cell.textLabel?.text = humaniseTime(movieSession.startTime!)
        cell.detailTextLabel?.text = movieSession.cinema?.name ?? "Melbourne CBD"
        return cell
    }
    
    private func humaniseTime(_ timeStr: String, _ format: String = "dd-MM-yyyy HH:mm:ss") -> String {
        var returnStr = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        if let date = formatter.date(from: timeStr) {
            formatter.dateFormat = "EEE dd MMM hh:mm aa"
            returnStr = formatter.string(from: date)
        }
        
        return returnStr
    }
    
}


extension MovieDetailsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openBookingDetailsFromMovieDetails" {
            let destinationVC = segue.destination as! BookingDetailsVC
            let indexPath = self.movieSessionsTableView.indexPathForSelectedRow
            let selectedSession = movieSessions[(indexPath?.row)!]
            let container = SimpleIOCContainer.instance
            
            destinationVC.movieSession = selectedSession
            destinationVC.movie = movie!
            destinationVC.cartRepository = container.resolve(ICartRepository.self)
            destinationVC.delegate = self
        }
        
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
