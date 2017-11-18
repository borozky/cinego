//
//  SwinjectStoryboard+Setup.swift
//  cinego
//
//  Created by Josh MacDev on 23/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//
import Firebase
import SwinjectStoryboard
import CoreData

extension SwinjectStoryboard {
    class func setup() {
        
        // FIREBASE CONFIGURATION
        // WARNING: Don't set up Firebase inside AppDelegate.swift
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        
        
        
        // FIREBASE SERVICE WRAPPERS
        defaultContainer.register(IFirebaseService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseMovieService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseCinemaService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseMovieSessionService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseUserService.self, factory: { _ in FirebaseService() })
        defaultContainer.register(IFirebaseBookingService.self, factory: { resolver in FirebaseService() })
        defaultContainer.register(ITMDBMovieService.self, factory: { _ in TMDBMovieService() })
        
        
        
        // COREDATA DEPENDENCIES
        defaultContainer.register(NSManagedObjectContext.self, factory: { resolver in
            return DatabaseController.getContext()
        })
        defaultContainer.register(CinemaCoreDataRepository.self, factory: { resolver in
            let context = resolver.resolve(NSManagedObjectContext.self)!
            return CinemaCoreDataRepository(context: context)
        })
        defaultContainer.register(MovieCoreDataRepository.self, factory: { resolver in
            let context = resolver.resolve(NSManagedObjectContext.self)!
            return MovieCoreDataRepository(context: context)
        })
        defaultContainer.register(MovieSessionCoreDataRepository.self, factory: { resolver in
            let context = resolver.resolve(NSManagedObjectContext.self)!
            return MovieSessionCoreDataRepository(context: context)
        })
        
        
        
        // SERVICE DEPENDENCIES
        defaultContainer.register(IMovieService.self, factory: { resolver in
            let firebaseMovieService = resolver.resolve(IFirebaseMovieService.self)!
            let tmdbMovieService = resolver.resolve(ITMDBMovieService.self)!
            let movieCoreDataRepository = resolver.resolve(MovieCoreDataRepository.self)!
            return MovieService(tmdbMovieService: tmdbMovieService, firebaseMovieService: firebaseMovieService, movieRepository: movieCoreDataRepository)
        })
        defaultContainer.register(ICinemaService.self, factory: { resolver in
            let repo = resolver.resolve(CinemaCoreDataRepository.self)!
            return CinemaService(cinemaRepository: repo)
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
        
        
        
        // VIEW MODELS
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
            let bookingService = resolver.resolve(IBookingService.self)!
            let userService = resolver.resolve((IUserService.self))!
            return CheckoutViewModel(bookingService: bookingService, userService: userService)
        })
        defaultContainer.register(AccountViewModel.self, factory: { resolver in
            let bookingService = resolver.resolve(IBookingService.self)!
            let userService = resolver.resolve(IUserService.self)!
            return AccountViewModel(bookingService: bookingService, userService: userService)
        })
        
        
        
        // VIEW CONTROLLERS
        // Setting up delegates for viewModels will happen 
        // automatically when ViewModels are injected (by using didSet{})
        defaultContainer.storyboardInitCompleted(HomeViewController.self, initCompleted: { resolver, controller in
            let homePageViewModel = resolver.resolve(HomePageViewModel.self)!
            controller.homePageViewModel = homePageViewModel
        })
        defaultContainer.storyboardInitCompleted(LoginVC.self, initCompleted: { resolver, controller in
            let authViewModel = resolver.resolve(AuthViewModel.self)!
            controller.authViewModel = authViewModel
            authViewModel.delegate = controller
            
            // AUTOMATICALLY move to account page ON LOGIN
            let userService = resolver.resolve(IUserService.self)!
            Auth.auth().addStateDidChangeListener { _ in
                
                // controller.delegate? will be supplied when coming in from Checkout page (checkout requires login)
                if controller.delegate == nil {
                    userService.getCurrentUser().then { user -> Void in
                        controller.performSegue(withIdentifier: "openAccountPageAfterLoggingIn", sender: user)
                    }.always {}
                }
            }
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
