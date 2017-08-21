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
    var isViewEditing = false
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var cartTotalPriceLabel: UILabel!
    @IBOutlet weak var cartItemsTable: UITableView!
    @IBOutlet weak var checkoutButton: UIBarButtonItem!
    @IBAction func editButtonDidTapped(_ sender: Any) {
       cartItemsTable.isEditing = !cartItemsTable.isEditing
        editButton.title = cartItemsTable.isEditing ? "Done": "Edit"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cartItemsTable.isEditing = false
        editButton.title = "Edit"
        setupCartTotalPrice()
        reload()
        if cartItems.count == 0{
            checkoutButton.isEnabled = false
        }
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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.cartItems.remove(at: indexPath.row)
        CartRepository.cart.remove(at: indexPath.row)
        cartItemsTable.deleteRows(at: [indexPath], with: .fade)
    //    cartTotalPriceLabel.text = NSString(cartRepository.getTotalPrice())
       
        cartTotalPriceLabel.text = NSString(format: "$ %.2f", cartRepository.getTotalPrice()) as String
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


