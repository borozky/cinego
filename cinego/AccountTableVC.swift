//
//  AccountTableVC.swift
//  cinego
//
//  Created by 何家红 on 7/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class AccountTableVC: UITableViewController {
    
    private let tableViewCellID = "UserOrdersTableViewCell"
    
    var user: User!
    var upcomingBookings: [Order] = []
    var pastOrders: [Order] = []
    var userRepository: IUserRepository!
    var orderRepository: IOrderRepository!
    
    @IBOutlet weak var userProfileView: UserProfileView!
    @IBOutlet var ordersTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileView.user = user
        
        // disable "swipe to go back"
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.backBarButtonItem?.isEnabled = false
        self.navigationItem.hidesBackButton = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return upcomingBookings.count
        }
        
        if section == 1 {
            return pastOrders.count
        }
        
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "UPCOMING SESSIONS"
        }
        if section == 1 {
            return "PAST ORDERS"
        }
        
        return nil
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        // upcoming movie bookings
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath)
            let orderItemView = cell.viewWithTag(1) as! OrderItemView
            orderItemView.order = upcomingBookings[indexPath.row]
            return cell
        }
        
        // past movie bookings
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath)
            let orderItemView = cell.viewWithTag(1) as! OrderItemView
            orderItemView.order = pastOrders[indexPath.row]
            return cell
        }
        
        return cell
        
    }
    
    func humanizeTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd MMM hh:mm aa"
        return formatter.string(from: date)
    }
}

extension AccountTableVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openOrderItemFromAccount" {
            let destinationVC = segue.destination as! OrderSummaryVC
            let indexPath = ordersTableView.indexPathForSelectedRow!
            switch indexPath.section {
            case 0:
                let order = upcomingBookings[indexPath.row]
                destinationVC.order = order
                destinationVC.notification = "The session will start on \(humanizeTime(order.movieSession.startTime))"
            case 1:
                destinationVC.order = pastOrders[indexPath.row]
                destinationVC.notification = "This session has already passed"
            default:
                break
            }
        }
    }
}



