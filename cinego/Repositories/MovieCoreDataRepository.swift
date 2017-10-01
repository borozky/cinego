//
//  MovieCoreDataRepository.swift
//  cinego
//
//  Created by Josh MacDev on 1/10/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import CoreData

protocol IMovieRepository: IRepository, IFindableById {}

class MovieCoreDataRepository: CoreDataRepository<MovieEntity>, IMovieRepository {
    func find(byId: String) -> MovieEntity? {
        let predicate = NSPredicate(format: "tmdb_id == %@", byId)
        let results = find(withPredicate: predicate)
        return results.first
    }
}


