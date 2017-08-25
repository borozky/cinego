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
    var selectedSeats: [Seat] = []

    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var priceBannerView: PriceBannerView!
    @IBOutlet weak var movieDetailsView: MovieDetailsView!
    @IBOutlet weak var orderSummaryView: OrderSummaryView!
    @IBOutlet weak var sessionDetailsView: SessionDetailsView!
    @IBOutlet weak var seatingArrangementView: SeatingArrangementView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceBannerView.price = 0.00
        movieDetailsView.movie = movieSession.movie
        orderSummaryView.total = 0.00
        seatingArrangementView.selectedSeats = selectedSeats
        seatingArrangementView.cinema = movieSession.cinema
        sessionDetailsView.movieSession = movieSession
    }
    
    override func viewDidAppear(_ animated: Bool) {
        priceBannerView.price = 0.00
        movieDetailsView.movie = movieSession.movie
        orderSummaryView.total = 0.00
        seatingArrangementView.selectedSeats = selectedSeats
        seatingArrangementView.cinema = movieSession.cinema
        sessionDetailsView.movieSession = movieSession
    }
    
    

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
