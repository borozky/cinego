//
//  CheckoutVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController {
    
    
    // TODO: Put these in a ViewModel
    var orderTotal = 0.00
    var movieSession: MovieSession!
    var selectedSeats: [Seat]!
    var userRepository: IUserRepository!
    var orderRepository: IOrderRepository!
    var user: User? {
        didSet {
            if self.user == nil {
                placeOrderButton.setTitle("Login to place your order", for: .normal)
            } else {
                placeOrderButton.setTitle("Place order", for: .normal)
            }
        }
    }
    

    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var priceBannerView: PriceBannerView!
    @IBOutlet weak var movieDetailsView: MovieDetailsView!
    @IBOutlet weak var orderSummaryView: OrderSummaryView!
    @IBOutlet weak var sessionDetailsView: SessionDetailsView!
    @IBOutlet weak var seatingArrangementView: SeatingArrangementView!
    
    @IBAction func placeOrderButtonDidTapped(_ sender: Any) {
        if user != nil {
            performSegue(withIdentifier: "placeOrderIfLoggedIn", sender: nil)
        } else {
            performSegue(withIdentifier: "showLoginPageIfNotLoggedIn", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceBannerView.price = orderTotal
        movieDetailsView.movie = movieSession.movie
        orderSummaryView.total = orderTotal
        seatingArrangementView.selectedSeats = selectedSeats
        seatingArrangementView.cinema = movieSession.cinema
        sessionDetailsView.movieSession = movieSession
        
        if self.user == nil {
            placeOrderButton.setTitle("Login to place your order", for: .normal)
        } else {
            placeOrderButton.setTitle("Place order", for: .normal)
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        priceBannerView.price = orderTotal
//        movieDetailsView.movie = movieSession.movie
//        orderSummaryView.total = orderTotal
//        seatingArrangementView.selectedSeats = selectedSeats
//        seatingArrangementView.cinema = movieSession.cinema
//        sessionDetailsView.movieSession = movieSession
//    }
    
    

}

extension CheckoutVC : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        // ACCOUNT table cell
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "AccountStatusTableViewCell", for: indexPath)
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
            let loggedInUser = userRepository.getCurrentUser()!
            let destinationVC = segue.destination.childViewControllers.first as! OrderSummaryVC
            self.user = loggedInUser
            
            // order
            let newOrder = Order(id: nil, userId: loggedInUser.id! , seats: selectedSeats, movieSession: movieSession)
            destinationVC.order = orderRepository.create(order: newOrder)!
            destinationVC.user = loggedInUser
            destinationVC.newOrder = true
            destinationVC.delegate = self
        }
        
        else if segue.identifier == "showLoginPageIfNotLoggedIn" {
            let destinationVC = segue.destination.childViewControllers.first as! LoginVC
            destinationVC.userRepository = userRepository
            destinationVC.delegate = self
        }
    }
}

extension CheckoutVC: LoginVCDelegate {
    func didLoggedIn(_ user: User) {
        self.user = user
    }
}

extension CheckoutVC: OrderSummaryVCDelegate {
    func barButtonRightDidTapped() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
}

