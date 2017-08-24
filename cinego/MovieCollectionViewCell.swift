//
//  MovieCollectionViewCell.swift
//  cinego
//
//  Created by Victor Orosco on 28/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerIcon: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    var movie: Movie!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
}
