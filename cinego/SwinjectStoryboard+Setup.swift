//
//  SwinjectStoryboard+Setup.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//
import Firebase
import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        
        defaultContainer.register(IMovieRepository.self, factory: { _ in MovieRepository()})
        defaultContainer.register(IMovieSessionRepository.self, factory: { _ in MovieSessionRepository() })
        defaultContainer.register(ICinemaRepository.self, factory: { _ in CinemaRepository() })
        defaultContainer.register(IUserRepository.self, factory: { _ in UserRepository() })
        defaultContainer.register(ICartRepository.self, factory: { _ in CartRepository() })
        defaultContainer.register(IOrderRepository.self, factory: { _ in OrderRepository() })
        
        defaultContainer.register(IFirebaseService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseMovieService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseCinemaService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseMovieSessionService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseUserService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(ITMDBMovieService.self, factory: { _ in TMDBMovieService() })
        
        defaultContainer.register(IMovieService.self, factory: { resolver in
            let firebaseMovieService = resolver.resolve(IFirebaseMovieService.self)!
            let tmdbMovieService = resolver.resolve(ITMDBMovieService.self)!
            return MovieService(tmdbMovieService: tmdbMovieService, firebaseMovieService: firebaseMovieService)
        })
        
        defaultContainer.register(ICinemaService.self, factory: { resolver in
            //let firebaseCinemaService = resolver.resolve(IFirebaseCinemaService.self)
            return CinemaService()
        })
        
        defaultContainer.register(IMovieSessionService.self, factory: { resolver in
            let firebaseMovieSessionService = resolver.resolve(IFirebaseMovieSessionService.self)!
            let movieService = resolver.resolve(IMovieService.self)!
            let cinemaService = resolver.resolve(ICinemaService.self)!
            return MovieSessionService(movieService: movieService, cinemaService: cinemaService, firebaseMovieSessionService: firebaseMovieSessionService)
        })
        
        defaultContainer.register(HomePageViewModel.self, factory: { resolver in
            let movieService = resolver.resolve(IMovieService.self)!
            let cinemaService = resolver.resolve(ICinemaService.self)!
            let movieSessionService = resolver.resolve(IMovieSessionService.self)!
            return HomePageViewModel(movieService: movieService, cinemaService: cinemaService, movieSessionService: movieSessionService)
        })
        
        defaultContainer.register(MovieDetailsViewModel.self, factory: { resolver in
            let movieSessionService = resolver.resolve(IMovieSessionService.self)!
            let movieService = resolver.resolve(IMovieService.self)!
            return MovieDetailsViewModel(movieSessionService: movieSessionService, movieService: movieService)
        })
        
        defaultContainer.storyboardInitCompleted(HomeViewController.self, initCompleted: { resolver, controller in
            let homePageViewModel = resolver.resolve(HomePageViewModel.self)!
            controller.homePageViewModel = homePageViewModel
            homePageViewModel.delegate = controller
        })
        
        defaultContainer.register(IUserService.self, factory: { resolver in
            let firebaseUserService = resolver.resolve(IFirebaseUserService.self)!
            return UserService(firebaseUserService: firebaseUserService)
        })
        
        defaultContainer.register(AuthViewModel.self, factory: { resolver in
            let userService = resolver.resolve(IUserService.self)!
            return AuthViewModel(userService: userService)
        })
        
        defaultContainer.storyboardInitCompleted(LoginVC.self, initCompleted: { resolver, controller in
            let authViewModel = resolver.resolve(AuthViewModel.self)!
            controller.authViewModel = authViewModel
            authViewModel.delegate = controller
        })
        
        defaultContainer.storyboardInitCompleted(RegisterVC.self, initCompleted: { resolver, controller in
            let authViewModel = resolver.resolve(AuthViewModel.self)!
            controller.authViewModel = authViewModel
            authViewModel.delegate = controller
        })
        
        defaultContainer.storyboardInitCompleted(MovieDetailsViewController.self, initCompleted: { resolver, controller in
            let movieDetailsViewModel = resolver.resolve(MovieDetailsViewModel.self)!
            controller.movieDetailsViewModel = movieDetailsViewModel
            movieDetailsViewModel.delegate = controller
        })
        
    }
}
