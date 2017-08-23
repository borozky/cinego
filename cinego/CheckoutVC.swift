//
//  CheckoutVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableViewCellID_1 = "AccountStatusTableViewCell"
    let tableViewCellID_2 = "PaymentMethodTableViewCell"
    let tableViewCellID_3 = "SessionBookingsTableViewCell"
    

    @IBOutlet weak var orderSubtotalLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var gstCostLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!
    
    var cartItems: [CartItem]!
    var cartRepository: CartRepository!
    
    var orderSubtotal = 0.00
    var shippingCost = 0.00
    var gst = 0.00
    var orderTotal = 0.00
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCheckoutCost()
    }
    
    
    func setupCheckoutCost(){
        orderSubtotalLabel?.text = String(format: "$ %.02f", self.orderSubtotal)
        shippingCostLabel?.text = String(format: "$ %.02f", self.shippingCost)
        gstCostLabel?.text = String(format: "$ %.02f", self.gst)
        orderTotalLabel?.text = String(format: "$ %.02f", orderTotal)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Bookings"
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        }
        
        return 66
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return tableView.sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : cartItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID_1, for: indexPath)
            return cell
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID_2, for: indexPath)
            return cell
        }
        
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID_3, for: indexPath)
            let bookingItem = cartItems[indexPath.row]
            let imageView = cell.viewWithTag(1) as! UIImageView
            let titleLabel = cell.viewWithTag(2) as! UILabel
            let detailsLabel = cell.viewWithTag(3) as! UILabel
            
            let numTicketsStr = "\(String(bookingItem.numTickets)) ticket\(bookingItem.numTickets != 1 ? "s" : "")"
            let sessionTimeStr = humaniseTime(bookingItem.movieSession!.startTime!)
            let cinemaStr = bookingItem.movieSession!.cinema!.name!
            
            imageView.image = UIImage(imageLiteralResourceName: bookingItem.movie!.images[0])
            titleLabel.text = bookingItem.movie!.title
            detailsLabel.text = "\(numTicketsStr) | \(sessionTimeStr) | \(cinemaStr)"
            
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 100
        }
        
        return tableView.sectionFooterHeight
    }
    
    private func humaniseTime(_ timeStr: String, _ format: String = "dd-MM-yyyy HH:mm:ss") -> String {
        var returnStr = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        if let date = formatter.date(from: timeStr) {
            formatter.dateFormat = "EEE dd MMM hh:mm aa"
            returnStr = formatter.string(from: date)
        }
        
        return returnStr
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
