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
    
    var cinemaRepository: ICinemaRepository!
    var movieRepository: IMovieRepository!
    
    var cinema: Cinema!
    
    
    lazy var cinemaMoviesVC: CinemaMoviesVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "CinemaMoviesVC") as! CinemaMoviesVC
        viewController.movies = self.movieRepository.getMovies(byCinema: self.cinema)
        viewController.cinema = self.cinema
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    
    lazy var cinemaInformationVC: CinemaInformationVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "CinemaInformationVC") as! CinemaInformationVC
        viewController.cinema = self.cinema
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
