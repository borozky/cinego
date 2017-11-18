//
//  MovieSessionCoreDataRepository.swift
//  cinego
//
//  Created by Josh MacDev on 1/10/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import CoreData

protocol IMovieSessionRepository: IRepository, IFindableById {}

// CRUD Methods for Movies
class MovieSessionCoreDataRepository: CoreDataRepository<MovieSessionEntity>, IMovieSessionRepository {
    
    func find(byId: String) -> MovieSessionEntity? {
        let predicate = NSPredicate(format: "firebaseId == %@", byId)
        let results = find(withPredicate: predicate)
        return results.first
    }
    
}
