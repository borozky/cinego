//
//  HomeViewController.swift
//  cinego
//
//  Created by Joshua Orozco on 7/25/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // I will deal with "dependency injection with storyboards" on Assignment 2
    var movieRepository: IMovieRepository? = MovieRepository()
    var cinemaRepository: ICinemaRepository? = CinemaRepository()
    
    
    @IBOutlet weak var homeBannerSlider: ImageSlider!
    @IBOutlet weak var upcomingMoviesCollectionView: UICollectionView!
    @IBOutlet weak var cinemaTheatersCollectionView: UICollectionView!
    
    
    var imageBanners = [UIImage]()
    var upcomingMovies: [UIImage] = [#imageLiteral(resourceName: "indigo-160x240"), #imageLiteral(resourceName: "fuchsia-160x240"), #imageLiteral(resourceName: "lime-160x240"), #imageLiteral(resourceName: "maroon-160x240"), #imageLiteral(resourceName: "scarlet-160x240"), #imageLiteral(resourceName: "olive-160x240"), #imageLiteral(resourceName: "teal-160x240")]
    var cinemaTheaters: [(location: String, image: UIImage)] = [
        ("Melbourne CBD", #imageLiteral(resourceName: "cinema-image1")),
        ("Fitzroy", #imageLiteral(resourceName: "cinema-image2")),
        ("St. Kilda", #imageLiteral(resourceName: "cinema-image3")),
        ("Sunshine", #imageLiteral(resourceName: "640x360"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadHomeBannerSlider()
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

}



extension HomeViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.upcomingMoviesCollectionView {
            return upcomingMovies.count
        }
        
        if collectionView == self.cinemaTheatersCollectionView {
            return (cinemaRepository?.getAllCinemas().count)!
        }
        
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.upcomingMoviesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
            cell.bannerIcon.image = upcomingMovies[indexPath.row]
            cell.movieTitle.text = "Movie title: Something blah"
            cell.movieReleaseYear.text = String(2017)
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
    
}









