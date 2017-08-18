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
    
    var movie: Movie!
    var movieAdditionalDetails: [(String, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func getDateFromStr(_ dateStr: String, _ format: String = "dd MMMM yyyy") -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateStr)!
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
            return movieAdditionalDetails.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Movie Summary"
        case 1:
            return "Details"
        case 2:
            return "Additional Details"
        default:
            return ""
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIDs[0], for: indexPath)
            tableView.estimatedRowHeight = 170
            tableView.rowHeight = UITableViewAutomaticDimension
            
            let imageView = cell.viewWithTag(1) as! UIImageView
            let titleLabel = cell.viewWithTag(2) as! UILabel
            let releasedYearLabel = cell.viewWithTag(3) as! UILabel
            let durationLabel = cell.viewWithTag(4) as! UILabel
            let ratingLabel = cell.viewWithTag(5) as! UILabel
            
            imageView.image = UIImage(imageLiteralResourceName: movie.images[0])
            titleLabel.text = movie.title
            
            let date = getDateFromStr(movie.releaseDate)
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            releasedYearLabel.text = "Released: \(String(year))"
            
            durationLabel.text = "Duration: \(String(movie.duration)) minutes"
            ratingLabel.text = "Rating: \(movie.audienceType ?? "PG")"
            
            return cell
        }
        
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIDs[1], for: indexPath)
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableViewAutomaticDimension
            
            let detailsLabel = cell.viewWithTag(6) as! UILabel
            detailsLabel.text = movie.details ?? ""
            
            return cell
        }
        
        if indexPath.section > 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIDs[2], for: indexPath)
            tableView.estimatedRowHeight = 66
            tableView.rowHeight = UITableViewAutomaticDimension
            
            let additionalDetail = movieAdditionalDetails[indexPath.row]
            cell.textLabel?.text = additionalDetail.0
            cell.detailTextLabel?.text = additionalDetail.1
            
            
            return cell
        }
        
        return cell
    }

}
