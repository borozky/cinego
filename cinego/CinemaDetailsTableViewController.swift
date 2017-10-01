//
//  CinemaDetailsTableViewController.swift
//  cinego
//
//  Created by Josh MacDev on 30/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit
import MapKit

class CinemaDetailsTableViewController: UITableViewController  {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var cinema: Cinema!
    var cinemaDetails: [(String, String, String)] {
        return [
            ("Cinema", self.cinema.name, "CinemaDetailsTableViewCell"),
            ("Address", self.cinema.address, "CinemaDetailOpenableTableViewCell")
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Flinders Street as default
        let coordinates = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
        let area = 500.00
        let region = MKCoordinateRegionMakeWithDistance(coordinates, area, area)
        mapView.setRegion(region, animated: false)
        let annotation = CinemaLocationAnnotation(coordinates, title: cinema.name, subtitle: cinema.address)
        mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CinemaDetailsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinemaDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cinemaDetails[indexPath.row].2)!
        cell.textLabel?.text = self.cinemaDetails[indexPath.row].0
        cell.detailTextLabel?.text = self.cinemaDetails[indexPath.row].1
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return cinema.details
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.reuseIdentifier == "CinemaDetailOpenableTableViewCell" {
            performSegue(withIdentifier: "openOneCinemaDetail", sender: nil)
        }
    }
}

extension CinemaDetailsTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openOneCinemaDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let tuple = cinemaDetails[indexPath.row]
            let destinationVC = segue.destination as! CinemaDetailTableViewController
            destinationVC.detailTitle = tuple.0
            destinationVC.detailDescription = tuple.1
        }
    }
}


class CinemaDetailTableViewController : UITableViewController {
    var detailTitle: String!
    var detailDescription: String?
    override func viewDidLoad() { super.viewDidLoad() }
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 0 }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { return detailTitle }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? { return detailDescription }
}

class CinemaLocationAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    init(_ coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}





