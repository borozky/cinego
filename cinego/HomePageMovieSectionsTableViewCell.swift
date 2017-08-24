//
//  HomePageMovieSectionsTableViewCell.swift
//  cinego
//
//  Created by Victor Orosco on 24/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class HomePageMovieSectionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    var movies: [Movie] = []
    var cinema: Cinema?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension HomePageMovieSectionsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let movie = movies[indexPath.row]
        cell.movie = movie
        cell.bannerIcon.image = UIImage(imageLiteralResourceName: movie.images[0])
        cell.movieTitle.text = movie.title
        return cell
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
