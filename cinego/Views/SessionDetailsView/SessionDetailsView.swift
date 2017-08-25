//
//  SessionDetailsView.swift
//  cinego
//
//  Created by Victor Orosco on 25/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

@IBDesignable
class SessionDetailsView: UIView {

    
    @IBOutlet var view: UIView!
    @IBOutlet weak var cinema: UILabel!
    @IBOutlet weak var cinemaAddress: UILabel!
    @IBOutlet weak var sessionStartTime: UILabel!
    
    var movieSession: MovieSession! {
        get {
            return self.movieSession
        }
        set {
            let movieSession = newValue!
            cinema.text = movieSession.cinema.name
            cinemaAddress.text = movieSession.cinema.address
            sessionStartTime.text = humanizeTime(movieSession.startTime)
        }
    }
    
    // Helper method: Date to readable time,
    // eg. Date() -> Mon Aug 28 09:30 am
    private func humanizeTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd MMM hh:mm aa"
        return formatter.string(from: date)
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
