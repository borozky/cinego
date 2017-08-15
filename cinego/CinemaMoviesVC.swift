//
//  CinemaMoviesViewController.swift
//  cinego
//
//  Created by Victor Orosco on 2/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CinemaMoviesVC: UIViewController {

    let tableViewCellID = "CinemaMovieTableViewCell"
    var movies: [Movie] = []
    var cinema: Cinema?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


// table views
extension CinemaMoviesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        
        let imageView = self.view.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(imageLiteralResourceName: movie.images[0])
        
        let textLabel = self.view.viewWithTag(2) as! UILabel
        textLabel.text = movie.title
        
        let detailsLabel = self.view.viewWithTag(3) as! UILabel
        detailsLabel.text = "Released \(String(getReleaseYear(movie.releaseDate)))"
        
        return cell
    }
    
    // helper method
    private func getReleaseYear(_ releaseDateStr: String, dateFormat: String = "dd MMMM yyyy") -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: releaseDateStr)
        let calendar = Calendar.current
        return calendar.component(.year, from: date!)
    }
    
}

// segues
extension CinemaMoviesVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openMovieDetailsFromCinemaMoviesVC" {
            let indexPath = tableView.indexPathForSelectedRow
            let selectedMovie = movies[(indexPath?.row)!]
            
            let destinationVC = segue.destination as! MovieDetailsViewController
            destinationVC.movie = selectedMovie
            destinationVC.cinema = self.cinema!
            destinationVC.movieSessionRepository = MovieSessionRepository()
        }
    }
}
