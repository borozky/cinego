//
//  MovieSessionEntity+CoreDataProperties.swift
//  cinego
//
//  Created by Josh MacDev on 30/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import CoreData


extension MovieSessionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieSessionEntity> {
        return NSFetchRequest<MovieSessionEntity>(entityName: "MovieSessionEntity");
    }

    @NSManaged public var firebaseId: Int16
    @NSManaged public var starttime: NSDate?
    @NSManaged public var cinema: CinemaEntity?
    @NSManaged public var movie: MovieEntity?

}
