//
//  HomeViewController.swift
//  cinego
//
//  Created by Joshua Orozco on 7/25/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var homeBannerSlider: UIScrollView!
    
    var imageBanners = [UIImage]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadHomeBannerSlider()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // loads the home page slider banner
    private func loadHomeBannerSlider() {
        imageBanners = [#imageLiteral(resourceName: "cinema-image1") ,#imageLiteral(resourceName: "cinema-image2"), #imageLiteral(resourceName: "cinema-image3"), #imageLiteral(resourceName: "640x360")]
        
        for i in 0..<imageBanners.count {
            
            let imageView = UIImageView()
            imageView.image = imageBanners[i]
            imageView.contentMode = .scaleAspectFill
            
            // images start from left edge of the screen; don't use [Int(self.view.frame.width) * i] because it will return an Int
            let xPos = self.view.frame.width * CGFloat(i)
            
            imageView.frame = CGRect(x: xPos, y: 0, width: self.homeBannerSlider.frame.width, height: self.homeBannerSlider.frame.height)
            
            // total slides' width = banner width * number of images
            homeBannerSlider.contentSize.width = homeBannerSlider.frame.width * CGFloat(i + 1)
            
            // insert the images to the slider
            homeBannerSlider.addSubview(imageView)
            
        }
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
