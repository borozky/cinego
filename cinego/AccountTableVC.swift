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
        
        // disable "swipe to go back"
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.backBarButtonItem?.isEnabled = false
        self.navigationItem.hidesBackButton = true
        
        viewModel.loadUserBookings(byUserID: viewModel.user!.id!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let user = viewModel.user!
        viewModel.loadUserBookings(byUserID: user.id!)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.upcomingBookings.count
        }
        if section == 1 {
            return viewModel.pastBookings.count
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
            orderItemView.booking = viewModel.upcomingBookings[indexPath.row]
            return cell
        }
        
        // past movie bookings
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath)
            let orderItemView = cell.viewWithTag(1) as! OrderItemView
            orderItemView.booking = viewModel.pastBookings[indexPath.row]
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
    func userInformationLoaded(_ user: User) {
    }
    func upcomingBookingsLoaded(_ bookings: [Booking]) {
        ordersTableView.reloadData()
    }
    func pastBookingsLoaded(_ bookings: [Booking]) {
        ordersTableView.reloadData()
    }
    func loggedOut() {
        self.delegate?.didLogout()
        _ = self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    func errorProduced(_ error: Error) {
    
    }
    func userInformationNotLoaded(_ error: Error) {
    
    }
    func bookingsNotLoaded(_ error: Error) {
    
    }
}



