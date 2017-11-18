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
    
    public func addImage(_ image: UIImage){
        images.append(image)
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        let xPos = frame.width * CGFloat(images.count - 1)
        imageView.frame = CGRect(x: xPos, y: 0, width: frame.width, height: frame.height)
        contentSize.width = frame.width * CGFloat(images.count)
        
        self.addSubview(imageView)
        
    }

}
