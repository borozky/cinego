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
import SwiftyJSON

// APPLICATION ENTRY POINT
// Theme Color: purple #9f79b8, rgb(159, 121, 184)
// Notes: Dependencies are registered in SwinjectStoryboard+Setup.swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        // WARNING: DO NOT SETUP FIREBASE HERE
        // Firebase is already set up inside SwinjectStoryboard+Setup.swift
        
        
        // load movies and cinemas from CoreDATA
        let movies = loadMovies()
        let cinemas = loadCinemas()
        for movie in movies { MOVIECACHE[movie.id] = movie }
        for cinema in cinemas { CINEMACACHE[cinema.id] = cinema }
        
        
        // edit navigation bar and status bar colors
        UINavigationBar.appearance().barTintColor = UIColor(red:0.57, green:0.38, blue:0.69, alpha:1.0)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
        
        
        // initialising viewcontrollers with SwinjectStoryboard
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
    
    
    // WHEN APP IS CLOSED, SAVE CACHED MOVIES, CINEMAS AND MOVIESESSIONS
    func applicationWillTerminate(_ application: UIApplication) {
        let movieSessions = Array(MOVIESESSIONCACHE.values)
        let movies = Array(MOVIECACHE.values)
        let cinemas = Array(CINEMACACHE.values)
        
        
        // save cinemas and movies FIRST before saving movie sessions
        print("SAVING DATA TO LOCAL DATABASE")
        saveCinemas(cinemas)
        saveMovies(movies)
        saveMovieSessions(movieSessions)
        print("FINISHED SAVING CINEMA, MOVIES AND MOVIESESSIONS")
    }
    
    func loadCinemas() -> [Cinema] {
        let cinemaRepository = CinemaCoreDataRepository(context: DatabaseController.getContext())
        let cinemaEntities = cinemaRepository.findAll()
        var cinemas: [Cinema] = []
        for cinemaEntity in cinemaEntities {
            guard let id = cinemaEntity.firebaseId else {
                continue
            }
            guard let name = cinemaEntity.name else {
                continue
            }
            guard let address = cinemaEntity.location else {
                continue
            }
            guard let details = cinemaEntity.details else {
                continue
            }
            guard let seatMatrixStr = cinemaEntity.seatMatrix else {
                continue
            }
            
            let matrixStr = seatMatrixStr.characters.split{$0 == "_"}.map(String.init)
            var matrixIntArray = [Int]()
            for i in matrixStr {
                let num = Int(i)!
                matrixIntArray.append(num)
            }
            let latitude = cinemaEntity.latitude
            let longitude = cinemaEntity.longitude
            let cinema = Cinema(id: id,
                                name: name,
                                address: address,
                                details: details,
                                images: [],
                                rows: ["a", "b", "c", "d"],
                                seatMatrix: matrixIntArray,
                                reservedSeats: [],
                                latitude: latitude, longitude: longitude)
            cinemas.append(cinema)
        }
        return cinemas
    }
    
    func loadMovies() -> [Movie] {
        let movieRepository = MovieCoreDataRepository(context: DatabaseController.getContext())
        let movieEntities = movieRepository.findAll()
        var movies: [Movie] = []
        
        for movieEntity in movieEntities {
            guard let jsonData = movieEntity.tmdb_json else {
                continue
            }
            
            let json = SwiftyJSON.JSON(data: jsonData as Data)
            do {
                let movie = try Movie(json: json)
                movies.append(movie)
            } catch {
                continue
            }
        }
        
        return movies
    }
    
    
    // SAVE CINEMAS TO DATABASE
    func saveCinemas (_ cinemas: [Cinema]) {
        let cinemaRepository = CinemaCoreDataRepository(context: DatabaseController.getContext())
        for cinema in cinemas {
            if let existingCinemaEntity = cinemaRepository.find(byId: cinema.id) {
                existingCinemaEntity.details = cinema.details
                existingCinemaEntity.latitude = cinema.latitude
                existingCinemaEntity.longitude = cinema.longitude
                existingCinemaEntity.name = cinema.name
                existingCinemaEntity.firebaseId = cinema.id
                existingCinemaEntity.location = cinema.address
                existingCinemaEntity.seatMatrix = cinema.seatMatrix.map { String($0) }.joined(separator: "_")
                do {
                    _ = try cinemaRepository.update(existingCinemaEntity)
                    print("CINEMA: \(cinema.name) SUCCESSFULLY UPDATED")
                } catch {
                    print("[ERROR] CINEMA: \(cinema.name) FAILED TO BE UPDATED")
                }
            } else {
                let cinemaEntity = cinemaRepository.create()
                cinemaEntity.details = cinema.details
                cinemaEntity.latitude = cinema.latitude
                cinemaEntity.longitude = cinema.longitude
                cinemaEntity.name = cinema.name
                cinemaEntity.firebaseId = cinema.id
                cinemaEntity.location = cinema.address
                cinemaEntity.seatMatrix = cinema.seatMatrix.map { String($0) }.joined(separator: "_")
                do {
                    _ = try cinemaRepository.insert(cinemaEntity)
                    print("CINEMA: \(cinema.name) SUCCESSFULLY INSERTED")
                } catch {
                    print("[ERROR] CINEMA: \(cinema.name) FAILED TO BE INSERTED. \(error)")
                }
            }
        }
    }
    
    
    // SAVE MOVIES TO DATABASE
    func saveMovies(_ movies: [Movie]) {
        let movieRepository = MovieCoreDataRepository(context: DatabaseController.getContext())
        for movie in movies {
            if let existingMovieEntity = movieRepository.find(byId: movie.id) {
                existingMovieEntity.duration = Int16(movie.duration)
                existingMovieEntity.firebase_id = movie.id
                existingMovieEntity.tmdb_id = movie.id
                existingMovieEntity.overview = movie.details
                existingMovieEntity.title = movie.title
                
                do {
                    if let json = MOVIEJSONCACHE[movie.id]  {
                        let jsonData = try json.rawData()
                        existingMovieEntity.tmdb_json = jsonData as NSData?
                    }
                    _ = try movieRepository.update(existingMovieEntity)
                    print("MOVIE: \(movie.title) SUCCESSFULLY UPDATED")
                } catch {
                    print("[ERROR] MOVIE: \(movie.title) FAILED TO UPDATE. \(error)")
                }
            }
            else {
                let movieEntity = movieRepository.create()
                movieEntity.duration = Int16(movie.duration)
                movieEntity.firebase_id = movie.id
                movieEntity.tmdb_id = movie.id
                movieEntity.overview = movie.details
                movieEntity.title = movie.title
                
                do {
                    if let json = MOVIEJSONCACHE[movie.id]  {
                        let jsonData = try json.rawData()
                        movieEntity.tmdb_json = jsonData as NSData?
                    }
                    _ = try movieRepository.insert(movieEntity)
                    print("MOVIE: \(movie.title) SUCCESSFULLY INSERTED")
                } catch {
                    print("[ERROR] MOVIE: \(movie.title) FAILED TO INSERTED. \(error)")
                }
            }
        }
    }
    
    
    // SAVE MOVIE SESSIONS
    // Movies and Cinemas must exist in the database first before saving movie sessions
    func saveMovieSessions (_ movieSessions: [MovieSession]) {
        let context = DatabaseController.getContext()
        let movieSessionRepository = MovieSessionCoreDataRepository(context: context)
        let movieRepository = MovieCoreDataRepository(context: context)
        let cinemaRepository = CinemaCoreDataRepository(context: context)
        
        for movieSession in movieSessions {
            
            // movies and cinemas must exist first
            guard let movieEntity = movieRepository.find(byId: movieSession.movie.id) else {
                continue
            }
            guard let cinemaEntity = cinemaRepository.find(byId: movieSession.cinema.id) else {
                continue
            }
            
            // update existing movie session locally
            if let existingMovieSession = movieSessionRepository.find(byId: movieSession.id) {
                existingMovieSession.cinema = cinemaEntity
                existingMovieSession.movie = movieEntity
                existingMovieSession.starttime = movieSession.startTime as NSDate?
                do {
                    _ = try movieSessionRepository.update(existingMovieSession)
                    print("MOVIE SESSION: \(movieSession.id) SUCCESSFULLY UPDATED")
                } catch {
                    print("[ERROR] MOVIE SESSION: \(movieSession.id) FAILED TO BE UPDATED. \(error)")
                }
                
                
            }
            // create a movie session
            else {
                let movieSessionEntity = movieSessionRepository.create()
                movieSessionEntity.cinema = cinemaEntity
                movieSessionEntity.movie = movieEntity
                movieSessionEntity.starttime = movieSession.startTime as NSDate?
                movieSessionEntity.firebaseId = Int16(movieSession.id)!
                do {
                    _ = try movieSessionRepository.insert(movieSessionEntity)
                    print("MOVIE SESSION: \(movieSession.id) SUCCESSFULLY ADDED")
                } catch {
                    print("[ERROR] MOVIE SESSION: \(movieSession.id) FAILED TO INSERTED. \(error)")
                }
                
            }
            
        }
        
    }
    
}

// Gets the top-most view controller
// https://stackoverflow.com/questions/42540644/how-to-get-current-viewcontroller-through-any-background-process-in-ios-swift
extension UIApplication
{
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        if let nav = base as? UINavigationController {
            let top = topViewController(nav.visibleViewController)
            return top
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                let top = topViewController(selected)
                return top
            }
        }
        
        if let presented = base?.presentedViewController {
            let top = topViewController(presented)
            return top
        }
        
        return base
    }
}



