//
//  OrderItemView.swift
//  cinego
//
//  Created by Victor Orosco on 25/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit
import Haneke

@IBDesignable
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
    
    var booking: Booking! {
        didSet {
            let url = URL(string: booking.movieSession.movie.images.first!)!
            movieBanner.hnk_setImageFromURL(url)
            totalPriceLabel.text = String(format: "$ %.02f", self.booking.price)
            numSeatsLabel.text = String(format: "%d seats >", self.booking.seats.count)
            cinemaLocationLabel.text = self.booking.movieSession.cinema.name
            cinemaAddressLabel.text = self.booking.movieSession.cinema.address
            
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE dd-MMM hh:mm aa"
            sessionStartLabel.text = formatter.string(from: self.booking.movieSession.startTime)
            movieTitleLabel.text = self.booking.movieSession.movie.title
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
