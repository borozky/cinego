//
//  UpcomingMoviesByCinemaTableViewCell.swift
//  cinego
//
//  Created by Victor Orosco on 29/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class UpcomingMoviesByCinemaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var audienceTypeLabel: UILabel!
    @IBOutlet weak var excerptLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
