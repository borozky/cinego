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
    var cartItems: [CartItem]!
    var cartRepository: CartRepository!
    var orderSubtotal = 0.00
    var shippingCost = 0.00
    var gst = 0.00
    var orderTotal = 0.00
    
    let tableViewCellID_1 = "AccountStatusTableViewCell"
    let tableViewCellID_2 = "PaymentMethodTableViewCell"
    let tableViewCellID_3 = "SessionBookingsTableViewCell"
    
    @IBOutlet weak var orderSubtotalLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var gstCostLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCheckoutCost()
    }
    
    
    private func setupCheckoutCost(){
        orderSubtotalLabel?.text = String(format: "$ %.02f", self.orderSubtotal)
        shippingCostLabel?.text = String(format: "$ %.02f", self.shippingCost)
        gstCostLabel?.text = String(format: "$ %.02f", self.gst)
        orderTotalLabel?.text = String(format: "$ %.02f", orderTotal)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openOrderSummary" {
            let orderSummaryVC = segue.destination as! OrderSummaryVC
            
        }
    }
    
    private func processOrder(_ cartItems: [CartItem]){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension CheckoutVC : UITableViewDataSource, UITableViewDelegate {
    
    // 2 sections: payment section and cart items
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 1st section has no title, 2nd section's title is "Bookings"
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Bookings"
        }
        
        return nil
    }
    
    
    // 2nd section cell's row height is bigger than normal
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        }
        
        return 66
    }
    
    // NO TOP SPACING on first section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return tableView.sectionHeaderHeight
    }
    
    
    // 1st section is only 2 cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : cartItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        // ACCOUNT table cell
        if indexPath.section == 0 && indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID_1, for: indexPath)
            return cell
        }
        
        // PAYMENT METHOD table cell
        if indexPath.section == 0 && indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID_2, for: indexPath)
            return cell
        }
        
        // BOOKINGS table cell
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID_3, for: indexPath)
            let bookingItem = cartItems[indexPath.row]
            let imageView = cell.viewWithTag(1) as! UIImageView
            let titleLabel = cell.viewWithTag(2) as! UILabel
            let detailsLabel = cell.viewWithTag(3) as! UILabel
            
            let numTicketsStr = "\(String(bookingItem.numTickets)) ticket\(bookingItem.numTickets != 1 ? "s" : "")"
            let sessionTimeStr = humaniseTime(bookingItem.movieSession.startTime)
            let cinemaStr = bookingItem.movieSession.cinema.name
            
            imageView.image = UIImage(imageLiteralResourceName: bookingItem.movieSession.movie.images[0])
            titleLabel.text = bookingItem.movieSession.movie.title
            detailsLabel.text = "\(numTicketsStr) | \(sessionTimeStr) | \(cinemaStr)"
            
            return cell
        }
        
        return cell
    }
    
    
    // footer spacing
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 100
        }
        return tableView.sectionFooterHeight
    }
    
    
    private func humaniseTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd MMM hh:mm aa"
        return formatter.string(from: date)
    }
}
