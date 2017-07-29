//
//  UpcomingMoviesByCinemaTableVC.swift
//  cinego
//
//  Created by Victor Orosco on 29/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class UpcomingMoviesByCinemaTableVC: UITableViewController {
    
    var cinema: Cinema?
    var upcomingMovies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesByCinemaTableViewCell", for: indexPath) as! UpcomingMoviesByCinemaTableViewCell
        cell.imageBanner.image = #imageLiteral(resourceName: "teal-160x240")
        cell.movieTitle.text = "The Devil Wears Prada"
        cell.audienceTypeLabel.text = "Text"
        cell.releaseYearLabel.text = "2017"
        cell.excerptLabel.text = "This is a text excerpt"
        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
}
