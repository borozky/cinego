//
//  OrderSummaryView.swift
//  cinego
//
//  Created by Victor Orosco on 25/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

@IBDesignable
class OrderSummaryView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var gstLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    
    var total: Double = 0.00 {
        didSet {
            subtotalLabel.text = String(format: "$ %.02f", (self.total - 5.00) * 0.9)
            shippingLabel.text = String(format: "$ %.02f", 5.00)
            gstLabel.text = String(format: "$ %.02f", (self.total - 5.00) * 0.1)
        }
    }
    
    // https://stackoverflow.com/documentation/ios/1362/custom-uiviews-from-xib-files#t=201708251212470621308
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "OrderSummaryView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        
        //setupView()
    }
    
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = self.bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        addSubview(view)
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }

}
