//
//  BookingDetailsVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class BookingDetailsVC: UIViewController {
    
    let tableViewCellID = "SelectedSeatsTableViewCell"
    
    var movie: Movie? = nil
    var movieSession: MovieSession? = nil
    var numTickets = 0
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieBannerImageView: UIImageView!
    
    @IBOutlet weak var cinemaLocationLabel: UILabel!
    @IBOutlet weak var cinemaAddressLabel: UILabel!
    @IBOutlet weak var movieSessionStartLabel: UILabel!
    
    @IBOutlet weak var ticketQuantityLabel: UILabel!
    @IBOutlet weak var ticketQuantityStepper: UIStepper!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieInformation()
        setupMovieSessionInformation()
        
    }
    
    
    func setupMovieInformation(){
        movieTitleLabel.text = movie?.title
        movieReleaseDateLabel.text = "Released: \(movie?.releaseDate ?? "")"
        movieBannerImageView.image = UIImage(imageLiteralResourceName: (movie?.images[0])!)
    }
    
    
    func setupMovieSessionInformation(){
        cinemaLocationLabel.text = movieSession?.cinema?.name
        cinemaAddressLabel.text = movieSession?.cinema?.address
        movieSessionStartLabel.text = movieSession?.startTime
    }
    

}

extension BookingDetailsVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        cell.textLabel?.text = "Seats"
        cell.detailTextLabel?.text = "1/1 seats selected"
        return cell
    }
}
