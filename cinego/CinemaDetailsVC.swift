//
//  CinemaDetailsViewController.swift
//  cinego
//
//  Created by Victor Orosco on 28/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CinemaDetailsVC: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var cinema: Cinema = Cinema(name: "Melbourne CBD",numSeats: 20,address: "123 Flinder St. Melbourne VIC",details: "This is the details of the cinema")
    
    
    lazy var cinemaMoviesVC: CinemaMoviesVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "CinemaMoviesVC") as! CinemaMoviesVC
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    
    lazy var cinemaInformationVC: CinemaInformationVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "CinemaInformationVC") as! CinemaInformationVC
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    func setupView(){
        setupSegmentedControl()
        updateView()
    }
    
    
    func updateView(){
        cinemaMoviesVC.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        cinemaInformationVC.view.isHidden = (segmentedControl.selectedSegmentIndex == 0)
        
    }
    
    
    func setupSegmentedControl(){
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Movies", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Details", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
    }
    
    
    func selectionDidChange(sender: UISegmentedControl){
        updateView()
    }
    
    
    func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParentViewController: self)
    }
    

}
