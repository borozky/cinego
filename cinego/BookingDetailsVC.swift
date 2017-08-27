//
//  BookingDetailsVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

protocol BookingDetailsVCDelegate: class {
    func didUpdateSeats(_ movieSession: MovieSession, _ selectedSeats: [Seat])
}

class BookingDetailsVC: UIViewController {
    
    weak var delegate: BookingDetailsVCDelegate?
    
    
    // TODO: These data shoul be in a ViewModel
    var movieSession: MovieSession!
    var selectedSeats: [Seat]!
    let pricePerTicket = 20.00
    
    @IBOutlet weak var proceedToCheckoutButton: UIButton!
    @IBOutlet weak var movieDetailsView: MovieDetailsView!
    @IBOutlet weak var sessionDetailsView: SessionDetailsView!
    @IBOutlet weak var seatingArrangementView: SeatingArrangementView!
    
    @IBAction func proceedToCheckoutButtonDidTapped(_ sender: Any) {
        guard selectedSeats.count > 0 else {
            return
        }
        performSegue(withIdentifier: "proceedToCheckout", sender: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsView.movie = movieSession.movie
        sessionDetailsView.movieSession = movieSession
        seatingArrangementView.cinema = movieSession.cinema
        seatingArrangementView.selectedSeats = selectedSeats
        seatingArrangementView.reservedSeats = []
        seatingArrangementView.pricePerSeat = pricePerTicket
        seatingArrangementView.delegate = self
        
        if selectedSeats.count > 0 {
            proceedToCheckoutButton.alpha = 1.0
        } else {
            proceedToCheckoutButton.alpha = 0.5
        }
    }
    
}

extension BookingDetailsVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "proceedToCheckout" {
            let destinationVC = segue.destination as! CheckoutVC
            let userRepository: IUserRepository = SimpleIOCContainer.instance.resolve(IUserRepository.self)!
            let orderRepository: IOrderRepository = SimpleIOCContainer.instance.resolve(IOrderRepository.self)!
            destinationVC.movieSession = movieSession
            destinationVC.selectedSeats = seatingArrangementView.selectedSeats
            destinationVC.isEditing = false
            destinationVC.orderTotal = seatingArrangementView.orderTotal
            destinationVC.userRepository = userRepository
            destinationVC.orderRepository = orderRepository
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let delegate = self.delegate as? MovieDetailsViewController {
            delegate.didUpdateSeats(movieSession, self.selectedSeats)
        }
    }
}

extension BookingDetailsVC: SeatingArrangementViewDelegate {
    func didUpdateSeats(_ selectedSeats: [Seat]) {
        self.selectedSeats = selectedSeats
        proceedToCheckoutButton.isEnabled = selectedSeats.count > 0
        
        if selectedSeats.count > 0 {
            proceedToCheckoutButton.alpha = 1.0
        } else {
            proceedToCheckoutButton.alpha = 0.5
        }
        delegate?.didUpdateSeats(movieSession, self.selectedSeats)
    }
}


