//
//  AppDelegate.swift
//  cinego
//
//  Created by Victor Orosco on 23/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit
import Firebase
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // All dependencies and Firebase Configuration are in SwinjectStoryboard+Setup.swift
        
        // Theme color is - purple #9f79b8, rgb(159, 121, 184)
        UINavigationBar.appearance().barTintColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:1.0)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "InitialTabBarController") as! UITabBarController
        initialViewController.selectedIndex = 0
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}
}



