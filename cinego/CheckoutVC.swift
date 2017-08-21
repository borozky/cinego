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
    
    var cartItems: [CartItem]!
    var cartRepository: CartRepository!
    
    var orderSubtotal = 0.00
    var shippingCost = 0.00
    var gst = 0.00
    var orderTotal = 0.00
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCheckoutCost()
    }
    
    
    func setupCheckoutCost(){
        orderSubtotalLabel?.text = String(format: "$ %.02f", self.orderSubtotal)
        shippingCostLabel?.text = String(format: "$ %.02f", self.shippingCost)
        gstCostLabel?.text = String(format: "$ %.02f", self.gst)
        orderTotalLabel?.text = String(format: "$ %.02f", orderTotal)
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
