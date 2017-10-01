//
//  TabBarController.swift
//  cinego
//
//  Created by Josh MacDev on 1/10/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // prevent account tab from going back when tabbar is pressed
        if selectedIndex == 1 && viewController == tabBarController.selectedViewController {
            return false
        }
        return true
        
        // uncomment this if you want to prevent all ViewController to go home when currently selected tab is pressed
        // return viewController != tabBarController.selectedViewController
    }
}
