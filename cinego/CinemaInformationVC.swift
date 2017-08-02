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
    
    var cinema: Cinema = Cinema(name: "Melbourne CBD", numSeats: 20, address: "123 Flinder St. Melbourne VIC", details: "This is the details of the cinema")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageSlider()
        setupCinemaInformation()
    }
    
    
    private func setupImageSlider(){
        imageSlider.addImage(#imageLiteral(resourceName: "cinema-image1"))
        imageSlider.addImage(#imageLiteral(resourceName: "cinema-image2"))
    }
    
    
    private func setupCinemaInformation(){
        cinemaTitleLabel.text = cinema.name
        cinemaAddressLabel.text = "Address: \(cinema.address)"
        
        if let numseatsStr = cinema.numSeats {
            cinemaNumberOfSeatsLabel.text = "Seats: \(String(numseatsStr))"
        }
        
        cinemaDetailsTextView.text = cinema.details
    }
    

}
