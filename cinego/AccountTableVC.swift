//
//  AccountTableVC.swift
//  cinego
//
//  Created by 何家红 on 7/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

protocol AccountTableVCDelegate: class {
    func didLogout()
}

class AccountTableVC: UITableViewController {
    
    var viewModel: AccountViewModel! {
        didSet { self.viewModel.delegate = self }
    }
    
    private let tableViewCellID = "UserOrdersTableViewCell"
    weak var delegate: AccountTableVCDelegate?
    @IBOutlet weak var userProfileView: UserProfileView!
    @IBOutlet var ordersTableView: UITableView!
    @IBAction func logoutDidTapped(_ sender: Any) {
        viewModel.logout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileView.user = viewModel.user!
        
        // DISABLE "swipe to go back" on ACCOUNT PAGE
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.backBarButtonItem?.isEnabled = false
        self.navigationItem.hidesBackButton = true
        
        viewModel.loadUserBookings(byUserID: viewModel.user!.id!)
    }
    
    // ALWAYS check user booking
    override func viewDidAppear(_ animated: Bool) {
        let user = viewModel.user!
        viewModel.loadUserBookings(byUserID: user.id!)
    }

    // 2 - Upcoming movie sessions & past movie sessions bookings
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 0 - Upcoming Sessions, 1 - Past Bookings
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.upcomingBookings.count > 0 ? viewModel.upcomingBookings.count : 1
        }
        if section == 1 {
            return viewModel.pastBookings.count > 0 ? viewModel.pastBookings.count : 1
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
        // By default show the cell that displays "No bookings found"
        var cell = tableView.dequeueReusableCell(withIdentifier: "NoBookingFoundTableViewCell")!
        
        // upcoming movie bookings, replace the default cell (Cell will "No bookings found") with the normal one
        if indexPath.section == 0 {
            if viewModel.upcomingBookings.count > 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath)
                let orderItemView = cell.viewWithTag(1) as! OrderItemView
                orderItemView.booking = viewModel.upcomingBookings[indexPath.row]
                return cell
            } else {
                return cell
            }
        }
        
        // past movie bookings
        if indexPath.section == 1 {
            if viewModel.pastBookings.count > 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath)
                let orderItemView = cell.viewWithTag(1) as! OrderItemView
                orderItemView.booking = viewModel.pastBookings[indexPath.row]
                return cell
            } else {
                return cell
            }
        }
        
        return cell
    }
    
    func humanizeTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd MMM hh:mm aa"
        return formatter.string(from: date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let noBookingsFoundHeight = CGFloat(66.0)
        
        if indexPath.section == 0 {
            if viewModel.upcomingBookings.count == 0 {
                return noBookingsFoundHeight
            }
        }
        
        if indexPath.section == 1 {
            if viewModel.pastBookings.count == 0 {
                return noBookingsFoundHeight
            }
        }
        
        return tableView.rowHeight
    }
}

extension AccountTableVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openOrderItemFromAccount" {
            let destinationVC = segue.destination as! BookingSummaryVC
            let indexPath = ordersTableView.indexPathForSelectedRow!
            switch indexPath.section {
            case 0:
                let booking = viewModel.upcomingBookings[indexPath.row]
                destinationVC.booking = booking
                destinationVC.notification = "The session will start on \(humanizeTime(booking.movieSession.startTime))"
            case 1:
                destinationVC.booking = self.viewModel.pastBookings[indexPath.row]
                destinationVC.notification = "This session has already passed"
            default:
                break
            }
        }
    }
}


extension AccountTableVC: AccountViewModelDelegate {
    
    // Go back to LOGIN PAGE on logout
    func loggedOut() {
        self.delegate?.didLogout()
        _ = self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func upcomingBookingsLoaded(_ bookings: [Booking]) {
        ordersTableView.reloadData()
    }
    
    func pastBookingsLoaded(_ bookings: [Booking]) {
        ordersTableView.reloadData()
    }
    
    
    func userInformationLoaded(_ user: User) {
        // nothing here
    }
    func errorProduced(_ error: Error) {
        // nothing here
    }
    func userInformationNotLoaded(_ error: Error) {
        // nothing here
    }
    func bookingsNotLoaded(_ error: Error) {
        // nothing here
    }
}



