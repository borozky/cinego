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
    
    var movie: Movie? = nil
    var movieSessions: [MovieSession] = []
    var cinema: Cinema = Cinema(name: "Melbourne CBD", numSeats: 20, address: "123 Flinders Street VIC 3000", details: "This is the details")
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovie()
        setupMovieSessions()
    }

    private func setupMovie(){
        movieBannerImageView.image = UIImage(imageLiteralResourceName: (movie?.images[0])!)
        movieTitleLabel.text =  movie?.title
        movieReleaseDateLabel.text = "Released: \(movie?.releaseDate ?? "")"
        movieDurationLabel.text = "Duration \(String(movie?.duration ?? 0)) minutes"
        movieAudienceTypeLabel.text = movie?.audienceType
        
    }
    
    private func setupMovieSessions(movieSessions: [MovieSession] = []){
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
    }


}


extension MovieDetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSessions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        cell.textLabel?.text = movieSessions[indexPath.row].startTime
        cell.detailTextLabel?.text = cinema.name
        return cell
        
    }
}

extension MovieDetailsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openBookingDetailsFromMovieDetails" {
            let destinationVC = segue.destination as! BookingDetailsVC
            let cell = sender as! UITableViewCell
            let indexPath = self.movieSessionsTableView.indexPathForSelectedRow
            let selectedSession = movieSessions[(indexPath?.row)!]
            destinationVC.movieSession = selectedSession
            destinationVC.movie = movie!
   
        }
    }
}
