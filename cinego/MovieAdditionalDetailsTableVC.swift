//
//  MovieAdditionalDetailsTableVC.swift
//  cinego
//
//  Created by Victor Orosco on 6/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class MovieAdditionalDetailsTableVC: UITableViewController {

    private let tableViewCellIDs: [String] = ["MovieSummaryTableViewCell", "MovieOverviewTableViewCell", "MovieAdditionalDetailTableViewCell"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewCellIDs.count
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
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIDs[0], for: indexPath)
            tableView.estimatedRowHeight = 170
            tableView.rowHeight = UITableViewAutomaticDimension
            return cell
        }
        
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIDs[1], for: indexPath)
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableViewAutomaticDimension
            return cell
        }
        
        if indexPath.section > 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIDs[2], for: indexPath)
            tableView.estimatedRowHeight = 66
            tableView.rowHeight = UITableViewAutomaticDimension
            return cell
        }
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
