//
//  CinemaCollectionViewCell.swift
//  cinego
//
//  Created by Victor Orosco on 29/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class CinemaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cinemaImage: UIImageView!
    @IBOutlet weak var cinemaViewFX: UIVisualEffectView!
    @IBOutlet weak var cinemaLabelParent: UIView!
    @IBOutlet weak var cinemaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
    
}
