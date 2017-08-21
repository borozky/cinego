//
//  AppDelegate.swift
//  cinego
//
//  Created by Victor Orosco on 23/7/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private func configureServices(_ container: SimpleIOCContainer) -> SimpleIOCContainer {
        container.register(IMovieRepository.self, factory: {
            return MovieRepository()
        })
        
        container.register(IMovieSessionRepository.self, factory: {
            return MovieSessionRepository()
        })
        
        container.register(ICinemaRepository.self, factory: {
            return CinemaRepository()
        })
        
        container.register(IUserRepository.self, factory: {
            return UserRepository()
        })
        
        container.register(ICartRepository.self, factory: {
            return CartRepository()
        })
        
        return container
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // https://stackoverflow.com/questions/39931463/swift-ios-change-the-color-of-a-navigation-bar
        UINavigationBar.appearance().barTintColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:1.0)   // purple #9f79b8, rgb(159, 121, 184)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // https://www.youtube.com/watch?v=Ehqnf1kHNGw at 4:23
        UIApplication.shared.statusBarStyle = .lightContent
        
        // https://stackoverflow.com/questions/26753925/set-initial-viewcontroller-in-appdelegate-swift
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "InitialTabBarController") as! UITabBarController
        
        // IOC Container
        let container = configureServices(SimpleIOCContainer.instance)
        
        
        // home page
        for childViewController in initialViewController.viewControllers?[0].childViewControllers ?? [] {
            if let homeViewController = childViewController as? HomeViewController {
                homeViewController.cinemaRepository = container.resolve(ICinemaRepository.self)
                homeViewController.movieRepository = container.resolve(IMovieRepository.self)
                break
            }
        }
       
        // cinema page
        for childViewController in initialViewController.viewControllers?[1].childViewControllers ?? [] {
            let childVC = childViewController.childViewControllers.first   // cinema tab is a UISplitViewController
            if let cinemaListTableVC = childVC as? CinemaListTableVC {
                cinemaListTableVC.cinemaRepository = container.resolve(ICinemaRepository.self)
                cinemaListTableVC.movieRepository = container.resolve(IMovieRepository.self)
                break
            }
        }
        
        // cart page
        for childViewController in initialViewController.viewControllers?[2].childViewControllers ?? [] {
            if let cartVC = childViewController as? CartVC {
                cartVC.cartRepository = container.resolve(ICartRepository.self)
                break
            }
        }
        
        // account page
        for childViewController in initialViewController.viewControllers?[3].childViewControllers ?? [] {
            if let accountTableVC = childViewController as? AccountTableVC {
                accountTableVC.userRepository = container.resolve(IUserRepository.self)
                accountTableVC.user = container.resolve(IUserRepository.self)?.find(byUsername: "s3526309")
                break
            }
        }
        
        initialViewController.selectedIndex = 0
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

