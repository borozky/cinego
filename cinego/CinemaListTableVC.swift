//
//  CinemaListTableVC.swift
//  cinego
//
//  Created by Joshua Orozco on 2/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CinemaListTableVC: UITableViewController {
    
    // TODO: Refactor into ViewModels
    var cinemaRepository: ICinemaRepository!
    var movieRepository: IMovieRepository!
    var cinemas: [Cinema] = []
    
    
    let tableViewCellID = "CinemaListTableViewCell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCinemas()
    }
    
    private func setupCinemas(){
        cinemas = cinemaRepository.getAllCinemas()
    }
}


// tableview
extension CinemaListTableVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinemas.count    // 4 cinemas
    }
    
    
    // custom cell with tags
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cinema = cinemas[indexPath.row]
        let numUpcomingMovies: Int = movieRepository.getUpcomingMovies(fromCinema: cinema).count
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        
        let imageView = self.view.viewWithTag(1) as! UIImageView
        let titleLabel = self.view.viewWithTag(2) as! UILabel
        let detailsLabel = self.view.viewWithTag(3) as! UILabel
        
        imageView.image = UIImage(imageLiteralResourceName: cinema.images[0] )
        titleLabel.text = cinema.name
        detailsLabel.text = "\(String(numUpcomingMovies)) upcoming movies"
        
        return cell
    }
    
    
    // to CinemaDetailsVC
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
            destinationVC.movieRepository = movieRepository as! MovieRepository!
            destinationVC.cinemaRepository = cinemaRepository
        }
    }
}

