//
//  BookingDetailsVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

protocol MovieSessionDetailsVCDelegate: class {
    func didUpdateSeats(_ movieSession: MovieSession, _ selectedSeats: [Seat])
}

class MovieSessionDetailsVC: UIViewController {
    
    weak var delegate: MovieSessionDetailsVCDelegate?
    
    var viewModel: MovieSessionDetailsViewModel! {
        didSet { self.viewModel.delegate = self }
    }
    
    @IBOutlet weak var proceedToCheckoutButton: UIButton!
    @IBOutlet weak var movieDetailsView: MovieDetailsView!
    @IBOutlet weak var sessionDetailsView: SessionDetailsView!
    @IBOutlet weak var seatingArrangementView: SeatingArrangementView!
    
    @IBAction func proceedToCheckoutButtonDidTapped(_ sender: Any) {
        guard viewModel.selectedSeats.count > 0 else {
            return
        }
        
        performSegue(withIdentifier: "proceedToCheckout", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailsView.movie = viewModel.movieSession.movie
        sessionDetailsView.movieSession = viewModel.movieSession
        seatingArrangementView.cinema = viewModel.movieSession.cinema
        seatingArrangementView.selectedSeats = viewModel.selectedSeats
        seatingArrangementView.reservedSeats = viewModel.reservedSeats
        seatingArrangementView.pricePerSeat = 20.00
        seatingArrangementView.delegate = self
        
        if viewModel.selectedSeats.count > 0 {
            proceedToCheckoutButton.isEnabled = true
            proceedToCheckoutButton.alpha = 1.0
        } else {
            proceedToCheckoutButton.alpha = 0.5
            proceedToCheckoutButton.isEnabled = false
        }
    }
    
}

extension MovieSessionDetailsVC : MovieSessionDetailsViewModelDelegate {
    func seatsUpdated(_ selectedSeats: [Seat]){
        delegate?.didUpdateSeats(viewModel.movieSession, viewModel.selectedSeats)
        guard proceedToCheckoutButton != nil else { return }
        if viewModel.selectedSeats.count > 0 {
            proceedToCheckoutButton.isEnabled = true
            proceedToCheckoutButton.alpha = 1.0
        } else {
            proceedToCheckoutButton.alpha = 0.5
            proceedToCheckoutButton.isEnabled = false
        }
    }
    
    func reservedSeatsRetrieved(_ reservedSeats: [Seat]) {
        seatingArrangementView.reservedSeats = reservedSeats
    }
    
    func priceUpdated(_ unitPrice: Double, _ totalPrice: Double) {
        seatingArrangementView.pricePerSeat = unitPrice
    }
}

extension MovieSessionDetailsVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "proceedToCheckout" {
            let destinationVC = segue.destination as! CheckoutVC
            
            destinationVC.viewModel.movieSession = viewModel.movieSession
            destinationVC.viewModel.selectedSeats = viewModel.selectedSeats
            destinationVC.viewModel.orderTotal = seatingArrangementView.orderTotal
            
            destinationVC.isEditing = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let delegate = self.delegate as? MovieDetailsViewController {
            delegate.didUpdateSeats(viewModel.movieSession, viewModel.selectedSeats)
        }
    }
}

extension MovieSessionDetailsVC: SeatingArrangementViewDelegate {
    func didUpdateSeats(_ selectedSeats: [Seat]) {
        self.viewModel.updateSeats(selectedSeats)
    }
}


