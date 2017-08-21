//
//  CartVC.swift
//  cinego
//
//  Created by Victor Orosco on 2/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CartVC: UIViewController {
    
    let tableViewCellID = "CartItemTableViewCell"
    var cartRepository: ICartRepository!
    var cartItems: [CartItem] = []
    
    @IBOutlet weak var cartTotalPriceLabel: UILabel!
    @IBOutlet weak var cartItemsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCartTotalPrice()
        reload()
    }
    
    private func reload(){
        cartItems = cartRepository!.getAll()
        cartItemsTable.reloadData()
    }
    
}

extension CartVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartItem = cartItems[indexPath.row]
        let movie = cartItem.movie!
        let movieSession = cartItem.movieSession!
        let cinema = movieSession.cinema!
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        let movieTitleLabel = cell.viewWithTag(2) as! UILabel
        let detailsLabel = cell.viewWithTag(3) as! UILabel
        
        imageView.image = UIImage(imageLiteralResourceName: cartItem.movie!.images[0])
        movieTitleLabel.text = movie.title
        detailsLabel.text = "\(String(cartItem.numTickets)) tickets | [Session Time] | \(cinema.name!)"
        return cell
    }
}

extension CartVC {
    func setupCartTotalPrice(){
        let totalPrice = cartRepository.getTotalPrice() + Double(cartRepository.getAll().count) * 5.0
        let totalPriceStr = NSString(format: "%.2f", totalPrice)
        cartTotalPriceLabel?.text = "$ \(String(totalPriceStr))"
    }
}

extension CartVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openBookingDetailsFromCartPage" {
            let indexPath = cartItemsTable.indexPathForSelectedRow!
            
            let selectedCartItem = cartItems[indexPath.row]
            let destinationVC = segue.destination as! BookingDetailsVC
            
            destinationVC.cartRepository = cartRepository
            destinationVC.cartItem = selectedCartItem
            destinationVC.delegate = self
            
        }
        
        else if segue.identifier == "openCheckout" {
            let checkoutVC = segue.destination as! CheckoutVC
            checkoutVC.cartItems = cartRepository.getAll()
            checkoutVC.cartRepository = cartRepository as! CartRepository
            checkoutVC.orderSubtotal = cartRepository.getTotalPrice() * 0.9
            checkoutVC.gst = cartRepository.getTotalPrice() * 0.1
            checkoutVC.shippingCost = 5.0 * Double(cartRepository.getAll().count)
            checkoutVC.orderTotal = checkoutVC.gst + checkoutVC.orderSubtotal + checkoutVC.shippingCost
            
            
            
        }
    }
}

extension CartVC: BookingDetailsVCDelegate {
    func didBook(_ cartItem: CartItem) {
        let movieId = cartItem.movie!.id!
        let sessionId = cartItem.movieSession!.id!
        
        for i in 0..<cartItems.count {
            guard cartItems[i].movie!.id! == movieId else {
                continue
            }
            
            guard cartItems[i].movieSession!.id! == sessionId else {
                continue
            }
            cartItems[i] = cartItem
        }
        
    }
}
