//
//  CheckoutVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController {
    
    var viewModel: CheckoutViewModel! {
        didSet { viewModel.delegate = self }
    }

    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var priceBannerView: PriceBannerView!
    @IBOutlet weak var movieDetailsView: MovieDetailsView!
    @IBOutlet weak var orderSummaryView: BookingSummaryView!
    @IBOutlet weak var sessionDetailsView: SessionDetailsView!
    @IBOutlet weak var seatingArrangementView: SeatingArrangementView!
    
    @IBOutlet weak var checkoutTableView: UITableView!
    @IBAction func placeOrderButtonDidTapped(_ sender: Any) {
        if viewModel.user != nil {
            viewModel.placeBooking()
        } else {
            performSegue(withIdentifier: "showLoginPageIfNotLoggedIn", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceBannerView.price = viewModel.orderTotal
        movieDetailsView.movie = viewModel.movieSession.movie
        orderSummaryView.total = viewModel.orderTotal
        seatingArrangementView.selectedSeats = viewModel.selectedSeats
        seatingArrangementView.cinema = viewModel.movieSession.cinema
        seatingArrangementView.isSeatSelectable = false
        sessionDetailsView.movieSession = viewModel.movieSession
        
        if viewModel.user != nil {
            placeOrderButton.setTitle("Place Order", for: .normal)
        } else {
            placeOrderButton.setTitle("Login to place your order", for: .normal)
        }
        
        viewModel.checkAuth()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // check auth
        viewModel.checkAuth()
    }
}

extension CheckoutVC : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2    // Account status and payment
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        // ACCOUNT table cell
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "AccountStatusTableViewCell", for: indexPath)
            if viewModel.user != nil {
                cell.detailTextLabel?.text = "Logged in as \(viewModel.user!.fullname)"
                cell.accessoryType = .checkmark
            } else {
                cell.detailTextLabel?.text = "Checking out as a guest"
                cell.accessoryType = .detailButton
            }
            return cell
        }
        
        // PAYMENT METHOD table cell
        if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodTableViewCell", for: indexPath)
            return cell
        }
        
        return cell
    }
}

extension CheckoutVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "placeOrderIfLoggedIn" {
            let loggedInUser = viewModel.user!
            let destinationVC = segue.destination.childViewControllers.first as! BookingSummaryVC
            
            // booking
            let booking = sender as! Booking
            destinationVC.booking = booking
            destinationVC.user = loggedInUser
            destinationVC.delegate = self
        }
        
        else if segue.identifier == "showLoginPageIfNotLoggedIn" {
            let destinationVC = segue.destination.childViewControllers.first as! LoginVC
            destinationVC.delegate = self
            destinationVC.goToAccountPage = false
        }
    }
}

extension CheckoutVC: CheckoutViewModelDelegate {
    func userLoggedIn(_ user: User) {
        checkoutTableView.reloadData()
        placeOrderButton.setTitle("Place order", for: .normal)
    }
    func bookingPlaced(_ booking: Booking) {
        performSegue(withIdentifier: "placeOrderIfLoggedIn", sender: booking)
    }
    func userLoggedOut(){
        checkoutTableView.reloadData()
        placeOrderButton.setTitle("Login to place your order", for: .normal)
    }
    
}

extension CheckoutVC: LoginVCDelegate {
    func didLoggedIn(_ user: User) {
        self.viewModel.user = user
    }
}

extension CheckoutVC: BookingSummaryVCDelegate {
    func barButtonRightDidTapped() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
}


