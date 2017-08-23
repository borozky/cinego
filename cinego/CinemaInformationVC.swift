//
//  CinemaInformationVC.swift
//  cinego
//
//  Created by Victor Orosco on 2/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CinemaInformationVC: UIViewController {
    
    @IBOutlet weak var imageSlider: ImageSlider!
    @IBOutlet weak var cinemaTitleLabel: UILabel!
    @IBOutlet weak var cinemaAddressLabel: UILabel!
    @IBOutlet weak var cinemaNumberOfSeatsLabel: UILabel!
    @IBOutlet weak var cinemaDetailsTextView: UITextView!
    
    var cinema: Cinema!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageSlider()
        setupCinemaInformation()
    }
    
    
    private func setupImageSlider(){
        for image in cinema.images {
            imageSlider.addImage(UIImage(imageLiteralResourceName: image))
        }
    }
    
    
    private func setupCinemaInformation(){
        cinemaTitleLabel.text = cinema.name
        cinemaAddressLabel?.text = cinema.address
        cinemaNumberOfSeatsLabel.text = "Seats: \(String(cinema.numSeats))"
        cinemaDetailsTextView.text = cinema.details
    }
    

}
