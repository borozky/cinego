//
//  OrderSummaryVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class OrderSummaryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableViewCellID_1 = "OrderDetailTableViewCell"
    let tableViewCellID_2 = "BookingOrderTableViewCell"
    
    @IBOutlet weak var notificationContainer: UIView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    
    var notification = "Your order has successfully been placed"
    var isSuccessfulOrder = true
    var orderSubTotal = 0.00
    var shippingCost = 0.00
    var gstCost = 0.00
    var orderTotal = 0.00
    var paymentMethod = "Paypal"
    var bookings: [Booking] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
        setupOrderTotal()
        
        // movie session setup are managed by numberOfRowsInSection & cellForRowAt
    }
    
    func setupNotification(){
        notificationContainer?.backgroundColor = isSuccessfulOrder ? UIColor.green : UIColor.red
        notificationLabel?.text = notification
    }
    
    
    func setupOrderTotal(){
        orderTotalLabel?.text = String(format: "$ %.02f", orderTotal)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Payment details"
        }
        if section == 1 {
            return "Movie Sessions"
        }
        
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 4 : bookings.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID_1, for: indexPath)
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Order Subtotal"
                cell.detailTextLabel?.text = String(format: "$ %.02f", orderSubTotal)
            case 1:
                cell.textLabel?.text = "Shipping Cost"
                cell.detailTextLabel?.text = String(format: "$ %.02f", shippingCost)
            case 2:
                cell.textLabel?.text = "GST"
                cell.detailTextLabel?.text = String(format: "$ %.02f", gstCost)
            case 3:
                cell.textLabel?.text = "Payment Method"
                cell.detailTextLabel?.text = String(format: "$ %.02f", paymentMethod)
            default:
                break
            }
            return cell
        }
        
        
        if indexPath.section == 1 {
            let booking = bookings[indexPath.row]
            (cell.viewWithTag(1) as! UIImageView).image = UIImage(imageLiteralResourceName: (booking.movie?.images[0])!)
            (cell.viewWithTag(2) as! UILabel).text = booking.movie?.title
            let numTicketsStr = String(format: "%d tickets", booking.numTickets)
            let sessionTimeStr = humaniseTime((booking.movieSession?.startTime)!)
            let cinemaLocation = booking.movieSession?.cinema?.name
            (cell.viewWithTag(2) as! UILabel).text = "\(numTicketsStr) | \(sessionTimeStr) | \(cinemaLocation)"
            return cell
        }
        
        return cell
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
