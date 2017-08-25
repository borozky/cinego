//
//  MovieDetailsView.swift
//  cinego
//
//  Created by Victor Orosco on 25/8/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

@IBDesignable
class MovieDetailsView: UIView {
    
    // WARNING TIP: 
    // DO NOT SET ROOT VIEW AS A CLASS OF TYPE MOVIEDETAILSVIEW or
    // ANY CUSTOM VIEW, LEAVE IT AS A DEFAULT PLAIN UIVIEW
    // IF YOU DO THAT, YOU WILL GENERATE AN INFINITE LOOP
    //
    // JUST DONT SET CUSTOM CLASS IN THE ROOTVIEW, DO IT IN FILE'S OWNER
    
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var movieBanner: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releasedYearLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var movie: Movie! {
        get { return self.movie }
        set {
            let movie = newValue!
            backgroundImage.image = UIImage(imageLiteralResourceName: movie.images[0])
            movieBanner.image = UIImage(imageLiteralResourceName: movie.images[0])
            movieTitleLabel.text = movie.title
            releasedYearLabel.text = String(format: "Released: %d", getReleaseYear(movie.releaseDate))
            durationLabel.text = String(format: "Duration: %d", movie.duration)
            ratingLabel.text = "Rating: \(movie.contentRating.rawValue)"
        }
    }
    
    // helper method
    private func getReleaseYear(_ releaseDateStr: String, dateFormat: String = "dd MMMM yyyy") -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: releaseDateStr)
        let calendar = Calendar.current
        return calendar.component(.year, from: date!)
    }
    
    
    // https://stackoverflow.com/documentation/ios/1362/custom-uiviews-from-xib-files#t=201708251212470621308
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        addSubview(view)
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
