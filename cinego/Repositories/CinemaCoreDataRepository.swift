//
//  CinemaCoreDataRepository.swift
//  cinego
//
//  Created by Josh MacDev on 30/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import CoreData

protocol ICinemaRepository: IRepository, IFindableById {}

class CinemaCoreDataRepository: CoreDataRepository<CinemaEntity>, ICinemaRepository {
    func find(byId: String) -> CinemaEntity? {
        let predicate = NSPredicate(format: "firebaseId == %@", byId)
        let results = find(withPredicate: predicate)
        return results.first
    }
}




















