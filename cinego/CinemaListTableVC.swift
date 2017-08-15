//
//  CinemaListTableVC.swift
//  cinego
//
//  Created by Joshua Orozco on 2/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CinemaListTableVC: UITableViewController {
    
    let tableViewCellID = "CinemaListTableViewCell"
    
    var cinemaRepository: ICinemaRepository? = CinemaRepository()
    var movieRepository: IMovieRepository? = MovieRepository()
    var cinemas: [Cinema] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cinemas = (cinemaRepository?.getAllCinemas())!
    }

}


// tableview cells
extension CinemaListTableVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinemas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cinema = cinemas[indexPath.row]
        let numUpcomingMovies: Int = movieRepository?.getUpcomingMovies(fromCinema: cinema).count ?? 0
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        
        let imageView = self.view.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(imageLiteralResourceName: cinema.images[0] )
        
        
        let titleLabel = self.view.viewWithTag(2) as! UILabel
        titleLabel.text = cinema.name
        
        let detailsLabel = self.view.viewWithTag(3) as! UILabel
        detailsLabel.text = "\(String(numUpcomingMovies)) upcoming movies"
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "openCinema", sender: nil)
    }
    
}

// segues
extension CinemaListTableVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openCinema" {
            let tableView = self.view as! UITableView
            let indexPath = tableView.indexPathForSelectedRow
            let selectedCinema = cinemas[(indexPath?.row)!]
            
            let destinationVC = segue.destination as! CinemaDetailsVC
            destinationVC.cinema = selectedCinema
            destinationVC.movieRepository = MovieRepository()
            destinationVC.cinemaRepository = cinemaRepository as! CinemaRepository?
        }
    }
}

