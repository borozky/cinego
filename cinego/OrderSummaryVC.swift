//
//  OrderSummaryVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

protocol OrderSummaryVCDelegate: class {
    func barButtonRightDidTapped()
}

class OrderSummaryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableViewCellID = "OrderDetailTableViewCell"
    
    weak var delegate: OrderSummaryVCDelegate?
    
    @IBOutlet weak var barButtonRight: UIBarButtonItem!
    @IBOutlet weak var notificationContainer: UIView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var priceBannerView: PriceBannerView!
    @IBOutlet weak var movieDetailsView: MovieDetailsView!
    @IBOutlet weak var sessionDetailsView: SessionDetailsView!
    @IBOutlet weak var seatingArrangementView: SeatingArrangementView!
    
    // TODO: Put these in a view model
    var notification = "Your order has successfully been placed"
    var user: User!
    var order: Order!
    var newOrder = false
    
    @IBAction func barButtonRightDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.barButtonRightDidTapped()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        priceBannerView.price = order.totalPrice
        movieDetailsView.movie = order.movieSession.movie
        sessionDetailsView.movieSession = order.movieSession
        seatingArrangementView.selectedSeats = order.seats
        seatingArrangementView.cinema = order.movieSession.cinema
        notificationContainer?.backgroundColor = UIColor.green
        notificationLabel?.text = notification
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    // 1st section is the order specifics, 2nd is about booked sessions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Payment details"
        }
        
        return nil
    }
    
    
    // currently there are 4 order details available for 1st section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        // for order details
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Order Subtotal"
                cell.detailTextLabel?.text = String(format: "$ %.02f", order.subtotal)
            case 1:
                cell.textLabel?.text = "Shipping Cost"
                cell.detailTextLabel?.text = String(format: "$ %.02f", order.shippingCost)
            case 2:
                cell.textLabel?.text = "GST"
                cell.detailTextLabel?.text = String(format: "$ %.02f", order.gst)
            case 3:
                cell.textLabel?.text = "Payment Method"
                cell.detailTextLabel?.text = order.paymentMethod.rawValue
            default:
                break
            }
            return cell
        }
        
        return cell
    }
    
    
    private func humaniseTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd MMM hh:mm aa"
        return formatter.string(from: date)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
