//
//  MovieDetailsViewController.swift
//  cinego
//
//  Created by Victor Orosco on 28/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableViewCellID = "MovieSessionTableViewCell"
    
    @IBOutlet weak var movieBannerImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieAudienceTypeLabel: UILabel!
    
    
    
    var cinema: Cinema = Cinema(name: "Melbourne CBD", numSeats: 20, address: "123 Flinders Street VIC 3000", details: "This is the details")
    var movieSessions: [MovieSession] = []
    var movie: Movie? = nil

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieSessions()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSessions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        cell.textLabel?.text = movieSessions[indexPath.row].startTime
        cell.detailTextLabel?.text = cinema.name
        return cell
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func setupMovieSessions(movieSessions: [MovieSession] = []){
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        self.movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
