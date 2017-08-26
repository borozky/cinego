//
//  OrderItemView.swift
//  cinego
//
//  Created by Victor Orosco on 25/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class OrderItemView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var movieBanner: UIImageView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var numSeatsLabel: UILabel!
    @IBOutlet weak var cinemaLocationLabel: UILabel!
    @IBOutlet weak var cinemaAddressLabel: UILabel!
    @IBOutlet weak var sessionStartLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!

    var order: Order! {
        get { return self.order }
        set {
            movieBanner.image = UIImage(imageLiteralResourceName: order.movieSession.movie.images[0])
            totalPriceLabel.text = String(format: "$ %.02f", order.totalPrice)
            numSeatsLabel.text = String(format: "%d seats >", order.numTickets)
            cinemaLocationLabel.text = order.movieSession.cinema.name
            cinemaAddressLabel.text = order.movieSession.cinema.address
            
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE dd-MMM hh:mm aa"
            sessionStartLabel.text = formatter.string(from: order.movieSession.startTime)
            movieTitleLabel.text = order.movieSession.movie.title
        }
    }
    
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
