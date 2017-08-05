//
//  CinemaMoviesViewController.swift
//  cinego
//
//  Created by Victor Orosco on 2/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CinemaMoviesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableViewCellID = "CinemaMovieTableViewCell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        cell.imageView?.image = #imageLiteral(resourceName: "olive-160x240")
        cell.textLabel?.text = "Movie title"
        cell.detailTextLabel?.text = "Released: 2017"
        return cell
    }
    

}
