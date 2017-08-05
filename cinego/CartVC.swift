//
//  CartVC.swift
//  cinego
//
//  Created by Victor Orosco on 2/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CartVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableViewCellID = "CartItemTableViewCell"
    
    @IBOutlet weak var cartTotalPriceLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCartTotalPrice()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        return cell
    }
    
    func setupCartTotalPrice(){
        cartTotalPriceLabel?.text = "$ 0.00"
    }
    
    

}
