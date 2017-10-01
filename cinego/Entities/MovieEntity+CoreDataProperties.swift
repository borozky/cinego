//
//  MovieEntity+CoreDataProperties.swift
//  cinego
//
//  Created by Josh MacDev on 1/10/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity");
    }

    @NSManaged public var duration: Int16
    @NSManaged public var firebase_id: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterImage: NSData?
    @NSManaged public var releasedDate: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var tmdb_id: String?
    @NSManaged public var tmdb_json: NSData?
    @NSManaged public var movieSessions: NSSet?

}

// MARK: Generated accessors for movieSessions
extension MovieEntity {

    @objc(addMovieSessionsObject:)
    @NSManaged public func addToMovieSessions(_ value: MovieSessionEntity)

    @objc(removeMovieSessionsObject:)
    @NSManaged public func removeFromMovieSessions(_ value: MovieSessionEntity)

    @objc(addMovieSessions:)
    @NSManaged public func addToMovieSessions(_ values: NSSet)

    @objc(removeMovieSessions:)
    @NSManaged public func removeFromMovieSessions(_ values: NSSet)

}
