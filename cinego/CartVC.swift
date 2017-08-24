//
//  CartVC.swift
//  cinego
//
//  Created by Victor Orosco on 2/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CartVC: UIViewController {
    
    // TODO: Refactor into ViewModels
    var cartRepository: ICartRepository!
    var cartItems: [CartItem] = []
    var isViewEditing = false
    
    
    let tableViewCellID = "CartItemTableViewCell"
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var cartTotalPriceLabel: UILabel!
    @IBOutlet weak var cartItemsTable: UITableView!
    @IBOutlet weak var checkoutButton: UIBarButtonItem!
    
    
    // edit button onclick
    @IBAction func editButtonDidTapped(_ sender: Any) {
       cartItemsTable.isEditing = !cartItemsTable.isEditing
        editButton.title = cartItemsTable.isEditing ? "Done": "Edit"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutButton.isEnabled = false
        editButton.title = "Edit"
        editButton.isEnabled = false
        cartItemsTable.isEditing = false
    }
    
    // ONAPPEAR: refresh the cart
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCartTotalPrice()
        reload()
        
        editButton.isEnabled = cartItems.count > 0
        checkoutButton.isEnabled = cartItems.count > 0
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
    
    // custom cell with 'tags'
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartItem = cartItems[indexPath.row]
        let movie = cartItem.movieSession.movie
        let movieSession = cartItem.movieSession
        let cinema = movieSession.cinema
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        let movieTitleLabel = cell.viewWithTag(2) as! UILabel
        let detailsLabel = cell.viewWithTag(3) as! UILabel
        
        imageView.image = UIImage(imageLiteralResourceName: movie.images[0])
        movieTitleLabel.text = movie.title
        detailsLabel.text = "\(String(cartItem.numTickets)) tickets | \(humaniseTime(movieSession.startTime)) | \(cinema.name)"
        return cell
    }
    
    
    // ON DELETE cart items
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        self.cartItems.remove(at: indexPath.row)
        CartRepository.cart.remove(at: indexPath.row)
        cartItemsTable.deleteRows(at: [indexPath], with: .fade)
        cartTotalPriceLabel.text = NSString(format: "$ %.2f", cartRepository.getTotalPrice()) as String
        
        if cartItems.count == 0 {
            cartItemsTable.isEditing = false
            editButton.isEnabled = false
            editButton.title = "Edit"
            checkoutButton.isEnabled = false
        }
        
    }
    
    // Helper method: Date to readable time,
    // eg. Date() -> Mon Aug 28 09:30 am
    private func humaniseTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd MMM hh:mm aa"
        return formatter.string(from: date)
    }
}



extension CartVC {
    
    // the big amount label in Cart Scene
    func setupCartTotalPrice(){
        let totalPrice = cartRepository.getTotalPrice() + Double(cartRepository.getAll().count) * 5.0
        let totalPriceStr = String(format: "%.2f", totalPrice)
        cartTotalPriceLabel?.text = "$ \(totalPriceStr)"
    }
}


// segues
extension CartVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // to MOVIE SESSION PAGE to update your cart items
        if segue.identifier == "openBookingDetailsFromCartPage" {
            let indexPath = cartItemsTable.indexPathForSelectedRow!
            let selectedCartItem = cartItems[indexPath.row]
            let destinationVC = segue.destination as! BookingDetailsVC
            
            destinationVC.cartRepository = cartRepository
            destinationVC.cartItem = selectedCartItem
            destinationVC.delegate = self
            
        }
        
        // to CHECKOUT PAGE
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

// HANDLE UPDATING cart items
extension CartVC: BookingDetailsVCDelegate {
    func didBook(_ cartItem: CartItem) {
        let movieId = cartItem.movieSession.movie.id
        let sessionId = cartItem.movieSession.id
        
        for i in 0..<cartItems.count {
            guard cartItems[i].movieSession.movie.id == movieId else {
                continue
            }
            
            guard cartItems[i].movieSession.id == sessionId else {
                continue
            }
            
            cartItems[i] = cartItem
        }
        
    }
}


