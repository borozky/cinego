//
//  HomeViewController.swift
//  cinego
//
//  Created by Joshua Orozco on 7/25/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // injected by AppDelegate
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
        } else {
            homeBannerSlider.addImage(#imageLiteral(resourceName: "cinema-image3"))
        }
    }
    
    private func loadUpcomingMovies(){
        upcomingMovies = (movieRepository?.getUpcomingMovies())!
    }
}



extension HomeViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.upcomingMoviesCollectionView {
            return (movieRepository?.getUpcomingMovies().count)!
        }
        
        if collectionView == self.cinemaTheatersCollectionView {
            return (cinemaRepository?.getAllCinemas().count)!
        }
        
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.upcomingMoviesCollectionView {
            let upcomingMovie = upcomingMovies[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
            cell.bannerIcon.image = UIImage(imageLiteralResourceName: upcomingMovie.images[0])
            cell.movieTitle.text = upcomingMovie.title
            cell.movieReleaseYear.text = String(getReleaseYear(upcomingMovie.releaseDate))
            cell.movieAudienceType.text = "PG"
            return cell
        }
        
        if collectionView == self.cinemaTheatersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CinemaCollectionViewCell", for: indexPath) as! CinemaCollectionViewCell
            let cinema = cinemaRepository?.getAllCinemas()[indexPath.row]
            cell.cinemaImage.image = UIImage(imageLiteralResourceName: cinema?.images[0] ?? "cinema-image-3")
            cell.cinemaLabel?.text = cinema?.name
            return cell
        }
        
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
        if segue.identifier == "openMovieDetailsFromHomepage" {
            let destinationVC = segue.destination as! MovieDetailsViewController
            let cell = sender as! UICollectionViewCell
            let indexPath = self.upcomingMoviesCollectionView.indexPath(for: cell)
            let selectedData = upcomingMovies[(indexPath?.row)!]
            let container = SimpleIOCContainer.instance
            
            destinationVC.movie = selectedData
            destinationVC.movieSessionRepository = container.resolve(IMovieSessionRepository.self)
        }
    }
    
}






