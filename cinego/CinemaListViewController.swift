//
//  CinemaListViewController.swift
//  cinego
//
//  Created by Victor Orosco on 28/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CinemaListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cinemas: [String] = ["Melbourne CBD", "St. Kilda", "Fitzroy", "Sunshine"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinemas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // https://stackoverflow.com/questions/41601105/how-to-dequeue-subtitle-uitableviewcell-in-code-properly
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CinemaTableViewCell") else {
                return UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "CinemaTableViewCell")
            }
            return cell
        }()
        
        cell.textLabel?.text = cinemas[indexPath.row]
        cell.detailTextLabel?.text = "0 upcoming movies"
        cell.imageView?.image = #imageLiteral(resourceName: "scarlet-160x240")
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
