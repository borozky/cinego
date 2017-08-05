//
//  CheckoutVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableViewCellID_1 = "AccountStatusTableViewCell"
    private let tableViewCellID_2 = "PaymentMethodTableViewCell"

    @IBOutlet weak var orderSubtotalLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var gstCostLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!
    
    var orderSubtotal = 70.00
    var shippingCost = 3.75
    var gst = 7.00
    var orderTotal = 81.15
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCheckoutCost()
        
    }
    
    
    func setupCheckoutCost(){
        orderSubtotalLabel?.text = String(self.orderSubtotal)
        shippingCostLabel?.text = String(self.shippingCost)
        gstCostLabel?.text = String(self.gst)
        orderTotalLabel?.text = String(orderTotal)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID_1, for: indexPath)
            return cell
        }
        
        if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID_2, for: indexPath)
            return cell
        }
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // IGNORE THIS FOR NOW
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
