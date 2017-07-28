//
//  MovieDetailsViewController.swift
//  cinego
//
//  Created by Victor Orosco on 28/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movieShows: [Show] = [
        Show(0, "9:30am - 12:30pm", 1),
        Show(1, "1:30pm - 4:30pm", 1),
        Show(2, "5:30pm - 8:30pm", 1),
        Show(3, "9:30am - 12:30am", 1),
        Show(4, "1:30am - 4:30am", 1)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = movieShows[indexPath.row].getStartTime()
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
