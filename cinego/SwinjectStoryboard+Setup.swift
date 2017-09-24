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
        
        // -----------------
        
        defaultContainer.register(IFirebaseService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseMovieService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseCinemaService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseMovieSessionService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseUserService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseBookingService.self, factory: { resolver in FirebaseService() })
        defaultContainer.register(ITMDBMovieService.self, factory: { _ in TMDBMovieService() })
        
        // ----------------
        
        
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
        
        defaultContainer.register(IUserService.self, factory: { resolver in
            let firebaseUserService = resolver.resolve(IFirebaseUserService.self)!
            return UserService(firebaseUserService: firebaseUserService)
        })
        
        defaultContainer.register(ITicketCalculationService.self, factory: { resolver in
            return TicketCalculationService()
        })
        
        defaultContainer.register(IBookingService.self, factory: { resolver in
            let firebaseBookingService = resolver.resolve(IFirebaseBookingService.self)!
            let userService = resolver.resolve(IUserService.self)!
            let movieSessionService = resolver.resolve(IMovieSessionService.self)!
            return BookingService(firebaseBookingService: firebaseBookingService, userService: userService, movieSessionService: movieSessionService)
        })
        
        
        // ----------------
        
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

        
        defaultContainer.register(AuthViewModel.self, factory: { resolver in
            let userService = resolver.resolve(IUserService.self)!
            return AuthViewModel(userService: userService)
        })
        
        defaultContainer.register(MovieSessionDetailsViewModel.self, factory: { resolver in
            let ticketCalculationService = resolver.resolve(ITicketCalculationService.self)!
            return MovieSessionDetailsViewModel(ticketCalculationService: ticketCalculationService)
        })
        
        defaultContainer.register(CheckoutViewModel.self, factory: { resolver in
            let ticketCalcService = resolver.resolve(ITicketCalculationService.self)!
            let userService = resolver.resolve((IUserService.self))!
            return CheckoutViewModel(ticketCalculationService: ticketCalcService, userService: userService)
        })
        
        defaultContainer.register(AccountViewModel.self, factory: { resolver in
            let bookingService = resolver.resolve(IBookingService.self)!
            let userService = resolver.resolve(IUserService.self)!
            return AccountViewModel(bookingService: bookingService, userService: userService)
        })
        
        //----------------
        
        defaultContainer.storyboardInitCompleted(HomeViewController.self, initCompleted: { resolver, controller in
            let homePageViewModel = resolver.resolve(HomePageViewModel.self)!
            
            // controller automatically set itself as delegate when viewmodel is injected.
            // See: Controllers/HomeViewController.swift
            controller.homePageViewModel = homePageViewModel
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
            controller.viewModel = movieDetailsViewModel
            movieDetailsViewModel.delegate = controller
        })
        
        defaultContainer.storyboardInitCompleted(MovieSessionDetailsVC.self, initCompleted: { resolver, controller in
            let viewModel = resolver.resolve(MovieSessionDetailsViewModel.self)!
            controller.viewModel = viewModel
        })
        
        defaultContainer.storyboardInitCompleted(CheckoutVC.self, initCompleted: { resolver, controller in
            let viewModel = resolver.resolve(CheckoutViewModel.self)!
            controller.viewModel = viewModel
        })
        
        defaultContainer.storyboardInitCompleted(AccountTableVC.self, initCompleted: { resolver, controller in
            let viewModel = resolver.resolve(AccountViewModel.self)!
            controller.viewModel = viewModel
        })
        
    }
}
