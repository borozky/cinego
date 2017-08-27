//
//  PriceBannerView.swift
//  cinego
//
//  Created by Victor Orosco on 25/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

@IBDesignable
class PriceBannerView: UIView {

    
    var title: String = "ORDER TOTAL" {
        didSet {
            titleLabel.text = self.title
        }
    }
    var price: Double = 0.00 {
        didSet{
            priceLabel.text = String(format: "$ %.02f", self.price)
        }
    }
    var currency: String = "$"
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    

    
    
    // https://stackoverflow.com/documentation/ios/1362/custom-uiviews-from-xib-files#t=201708251212470621308
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
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
