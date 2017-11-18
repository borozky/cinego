//
//  CinemaEntity+CoreDataProperties.swift
//  cinego
//
//  Created by Josh MacDev on 30/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import CoreData


extension CinemaEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CinemaEntity> {
        return NSFetchRequest<CinemaEntity>(entityName: "CinemaEntity");
    }

    @NSManaged public var details: String?
    @NSManaged public var firebaseId: String?
    @NSManaged public var images: NSData?
    @NSManaged public var latitude: Double
    @NSManaged public var location: String?
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var seatMatrix: String?
    @NSManaged public var movieSessions: NSSet?

}

// MARK: Generated accessors for movieSessions
extension CinemaEntity {

    @objc(addMovieSessionsObject:)
    @NSManaged public func addToMovieSessions(_ value: MovieSessionEntity)

    @objc(removeMovieSessionsObject:)
    @NSManaged public func removeFromMovieSessions(_ value: MovieSessionEntity)

    @objc(addMovieSessions:)
    @NSManaged public func addToMovieSessions(_ values: NSSet)

    @objc(removeMovieSessions:)
    @NSManaged public func removeFromMovieSessions(_ values: NSSet)

}
