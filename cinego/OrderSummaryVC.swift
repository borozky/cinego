//
//  OrderSummaryVC.swift
//  cinego
//
//  Created by Victor Orosco on 5/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class OrderSummaryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableViewCellID = "BookingOrderTableViewCell"
    
    @IBOutlet weak var notificationContainer: UIView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var orderSubtotalLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var gstCostLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    
    var movieSessions: [MovieSession] = []
    var orderTotal = 81.15
    var orderSubtotal = 70.00
    var shippingCost = 3.75
    var gstCost = 7.40
    var paymentMethod = "Paypal"
    var notification = "Your order has successfully been placed"
    var isSuccessfulOrder = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
        setupOrderTotal()
        setupOrderDetails()
        
        // movie session setup are managed by numberOfRowsInSection & cellForRowAt
    }
    
    
    func setupNotification(){
        notificationContainer?.backgroundColor = isSuccessfulOrder ? UIColor.green : UIColor.red
        notificationLabel?.text = notification
    }
    
    
    func setupOrderTotal(){
        orderTotalLabel?.text = "$ \(String(orderTotal))"
    }
    
    
    func setupOrderDetails(){
        orderSubtotalLabel?.text = "$ \(String(orderSubtotal))"
        shippingCostLabel?.text = "$ \(String(shippingCost))"
        gstCostLabel?.text = "$ \(String(gstCost))"
        paymentMethodLabel?.text = paymentMethod
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellID, for: indexPath)
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
