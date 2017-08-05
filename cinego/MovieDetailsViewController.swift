//
//  MovieDetailsViewController.swift
//  cinego
//
//  Created by Victor Orosco on 28/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cinema: Cinema = Cinema(name: "Melbourne CBD",
                                numSeats: 20,
                                address: "123 Flinders Street VIC 3000",
                                details: "This is the details")
    
    var movieSessions: [MovieSession] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        movieSessions.append(MovieSession(id: movieSessions.count + 1, startTime: "28 July 2017 08:30am", cinema: self.cinema))
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSessionTableViewCell", for: indexPath)
        cell.textLabel?.text = movieSessions[indexPath.row].startTime
        cell.detailTextLabel?.text = cinema.name
        return cell
        
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
