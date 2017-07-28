//
//  ImageSlider.swift
//  cinego
//
//  Created by Victor Orosco on 28/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class ImageSlider: UIScrollView {
    
    var images: [UIImage] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func addImage(image: UIImage){
        images.append(image)
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        
        let xPos = frame.width * CGFloat(images.count)
        imageView.frame = CGRect(x: xPos, y: 0, width: frame.width, height: frame.height)
        contentSize.width = frame.width * CGFloat(images.count)
        
        self.addSubview(imageView)
    }
    
    
    
    
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
