//
//  HomeViewController.swift
//  cinego
//
//  Created by Joshua Orozco on 7/25/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // TODO: Refactor with ViewModels
    var movieRepository: IMovieRepository!
    var cinemaRepository: ICinemaRepository!
    var upcomingMovies: [Movie] = []
    
    @IBOutlet weak var homeBannerSlider: ImageSlider!
    @IBOutlet weak var upcomingMoviesCollectionView: UICollectionView!
    @IBOutlet weak var cinemaTheatersCollectionView: UICollectionView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHomeBannerSlider()
        loadUpcomingMovies()
        
    }
    
    
    private func loadHomeBannerSlider() {
        let cinemas = cinemaRepository?.getAllCinemas()
        
        if let _cinemas = cinemas {
            for cinema in _cinemas {
                if cinema.images.count > 0 {
                    homeBannerSlider.addImage(UIImage(imageLiteralResourceName: cinema.images[0]))
                }
            }
            
        // default image
        } else {
            homeBannerSlider.addImage(#imageLiteral(resourceName: "cinema-image3"))
        }
    }
    
    
    private func loadUpcomingMovies(){
        upcomingMovies = (movieRepository?.getUpcomingMovies())!
    }
}



extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // UPCOMING MOVIES section - >5 cinemas
        if collectionView == self.upcomingMoviesCollectionView {
            return (movieRepository?.getUpcomingMovies().count)!
        }
        
        // CINEMA THEATERS section - 4 cinemas
        if collectionView == self.cinemaTheatersCollectionView {
            return (cinemaRepository?.getAllCinemas().count)!
        }
        
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // cells for UPCOMING MOVIES
        if collectionView == self.upcomingMoviesCollectionView {
            let upcomingMovie = upcomingMovies[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
            cell.bannerIcon.image = UIImage(imageLiteralResourceName: upcomingMovie.images[0])
            cell.movieTitle.text = upcomingMovie.title
            cell.movieReleaseYear.text = String(getReleaseYear(upcomingMovie.releaseDate))
            cell.movieAudienceType.text = "PG"
            return cell
        }
        
        // cell for CINEMA THEATER
        if collectionView == self.cinemaTheatersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CinemaCollectionViewCell", for: indexPath) as! CinemaCollectionViewCell
            let cinema = cinemaRepository?.getAllCinemas()[indexPath.row]
            cell.cinemaImage.image = UIImage(imageLiteralResourceName: cinema?.images[0] ?? "cinema-image-3")
            cell.cinemaLabel?.text = cinema?.name
            
            cell.cinema = cinema
            
            return cell
        }
        
        // some default cell
        return UICollectionViewCell()
    }
    
    
    // helper method
    private func getReleaseYear(_ releaseDateStr: String, dateFormat: String = "dd MMMM yyyy") -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: releaseDateStr)
        let calendar = Calendar.current
        return calendar.component(.year, from: date!)
    }
    
}


extension HomeViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // to Movie Details Page
        if segue.identifier == "openMovieDetailsFromHomepage" {
            let destinationVC = segue.destination as! MovieDetailsViewController
            let cell = sender as! UICollectionViewCell
            let indexPath = self.upcomingMoviesCollectionView.indexPath(for: cell)
            let selectedData = upcomingMovies[(indexPath?.row)!]
            let container = SimpleIOCContainer.instance
            destinationVC.movie = selectedData
            destinationVC.movieSessionRepository = container.resolve(IMovieSessionRepository.self) // DI w/ IOC
        }
            
        // to Movies By Cinema page
        else if segue.identifier == "openCinemaFromHome"{
            let selectedCinemaCollectionViewCell = sender as! CinemaCollectionViewCell
            let cinemaDetailsVC = segue.destination as! CinemaDetailsVC
            cinemaDetailsVC.movieRepository = movieRepository
            cinemaDetailsVC.cinemaRepository = cinemaRepository
            cinemaDetailsVC.cinema = selectedCinemaCollectionViewCell.cinema
            
        }
        
    }
    

}






