//
//  AccountTableVC.swift
//  cinego
//
//  Created by 何家红 on 7/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class AccountTableVC: UITableViewController {
    
    private let tableViewCellIDs = ["UserInformationTableViewCell", "UserUpcomingMovieSessionTableViewCell", "UserPastOrderTableViewCell"]
    
    var user: User!
    var upcomingBookings: [Booking] = []
    var pastOrders: [Order] = []
    
    var userRepository: IUserRepository?

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        if section == 1 {
            return 1
        }
        
        if section == 2 {
            return 1
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        // the user account information
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIDs[0], for: indexPath)
            let imageView = cell.viewWithTag(1) as! UIImageView
            let fullnameLable = cell.viewWithTag(2) as! UILabel
            let emialLable = cell.viewWithTag(3) as! UILabel
            
            imageView.image = #imageLiteral(resourceName: "guest")
            fullnameLable.text = user.fullname
            emialLable.text = user.email
            return cell
        }
        
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIDs[1], for: indexPath)
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableViewAutomaticDimension
            return cell
        }
        
        if indexPath.section == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIDs[2], for: indexPath)
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableViewAutomaticDimension
            return cell
        }
        
        
        
        return cell
    }
    
    
}
