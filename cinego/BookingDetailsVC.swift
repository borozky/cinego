//
//  BookingDetailsVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class BookingDetailsVC: UIViewController {
    
    
    // TODO: These data shoul be in a ViewModel
    var movieSession: MovieSession!
    var selectedSeats: [Seat] = []
    let pricePerTicket = 20.00
    
    @IBOutlet weak var proceedToCheckoutButton: UIButton!
    @IBOutlet weak var movieDetailsView: MovieDetailsView!
    @IBOutlet weak var sessionDetailsView: SessionDetailsView!
    @IBOutlet weak var seatingArrangementView: SeatingArrangementView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsView.movie = movieSession.movie
        sessionDetailsView.movieSession = movieSession
        seatingArrangementView.cinema = movieSession.cinema
        seatingArrangementView.selectedSeats = selectedSeats
        seatingArrangementView.reservedSeats = []
        seatingArrangementView.pricePerSeat = pricePerTicket
    }
    
}

extension BookingDetailsVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "proceedToCheckout" {
            let destinationVC = segue.destination as! CheckoutVC
            destinationVC.movieSession = movieSession
            destinationVC.selectedSeats = seatingArrangementView.selectedSeats
            destinationVC.orderTotal = seatingArrangementView.orderTotal
        }
    }
}
