//
//  HomeViewController.swift
//  cinego
//
//  Created by Joshua Orozco on 7/25/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var homeBannerSlider: UIScrollView!
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
    
    // loads the home page slider banner
    private func loadHomeBannerSlider() {
        imageBanners = [#imageLiteral(resourceName: "cinema-image1") ,#imageLiteral(resourceName: "cinema-image2"), #imageLiteral(resourceName: "cinema-image3"), #imageLiteral(resourceName: "640x360")]
        
        for i in 0..<imageBanners.count {
            let imageView = UIImageView()
            imageView.image = imageBanners[i]
            imageView.contentMode = .scaleAspectFill
            let xPos = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: self.homeBannerSlider.frame.width, height: self.homeBannerSlider.frame.height)
            homeBannerSlider.contentSize.width = homeBannerSlider.frame.width * CGFloat(i + 1)
            homeBannerSlider.addSubview(imageView)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.upcomingMoviesCollectionView {
            return upcomingMovies.count
        }
        
        if collectionView == self.cinemaTheatersCollectionView {
            return self.cinemaTheaters.count
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
            cell.cinemaImage.image = cinemaTheaters[indexPath.row].image
            cell.cinemaLabel?.text = cinemaTheaters[indexPath.row].location
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
