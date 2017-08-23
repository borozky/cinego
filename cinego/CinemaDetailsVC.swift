//
//  CinemaDetailsViewController.swift
//  cinego
//
//  Created by Victor Orosco on 28/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CinemaDetailsVC: UIViewController {
    
    // TODO: Refactor into ViewModels
    var cinemaRepository: ICinemaRepository!
    var movieRepository: IMovieRepository!
    var cinema: Cinema!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    // This view controller will ViewController for 
    // - List of movies of current cinema
    // - Current cinema information
    lazy var cinemaMoviesVC: CinemaMoviesVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "CinemaMoviesVC") as! CinemaMoviesVC
        viewController.movies = self.movieRepository.getMovies(byCinema: self.cinema)
        viewController.cinema = self.cinema
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    
    // This view controller will ViewController for
    // - List of movies of current cinema (lazy var cinemaMoviesVC)
    // - Current cinema information (lazy var cinemaInformationVC)
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
    
    
    private func setupView(){
        setupSegmentedControl()
        updateView()
    }
    
    
    private func updateView(){
        cinemaMoviesVC.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        cinemaInformationVC.view.isHidden = (segmentedControl.selectedSegmentIndex == 0)
    }
    
    
    private func setupSegmentedControl(){
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
