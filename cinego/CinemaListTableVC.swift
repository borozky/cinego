//
//  CinemaListTableVC.swift
//  cinego
//
//  Created by Joshua Orozco on 2/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CinemaListTableVC: UITableViewController {
    
    var cinemas: [Cinema] = [
        Cinema(name: "Melbourne CBD ",
               numSeats: 20,
               address: "123 Flinders Street, Melbourne VIC 3000",
               details: "This is the details of the movie theater"),
        Cinema(name: "Fitzroy",
               numSeats: 30,
               address: "207 Fitzroy St, Fitzroy VIC 3065",
               details: "Fitzroy cinema has the most number of seats of all movie theaters"),
        Cinema(name: "St. Kilda",
               numSeats: 25,
               address: "500 Barkly Street, St. Kilda VIC 3182",
               details: "..."),
        Cinema(name: "Sunshine",
               numSeats: 25,
               address: "80  Harvester Road, Sunshine VIC 3020",
               details: "...")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinemas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "CinemaListTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CinemaListTableViewCell", for: indexPath)
        cell.textLabel?.text = cinemas[indexPath.row].name
        cell.detailTextLabel?.text = "10 upcoming movies"
        cell.imageView?.image = #imageLiteral(resourceName: "olive-160x240")
        cell.imageView?.contentMode = .scaleToFill
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "openCinema", sender: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
