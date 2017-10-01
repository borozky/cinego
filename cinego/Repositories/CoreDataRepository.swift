//
//  CoreDataRepository.swift
//  cinego
//
//  Created by Josh MacDev on 1/10/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import CoreData

protocol ICoreDataRepository: IRepository {
    associatedtype T
    func find(withPredicate: NSPredicate) -> [T]
}

// Root class for Core Data Repository classes
class CoreDataRepository<T> : ICoreDataRepository where T: NSManagedObject {
    
    var context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // Creates an instance of NSManagedObject entity
    func create() -> T {
        let entityName = String(describing: T.self)
        let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! T
        return entity
    }
    
    // Find all entities
    func findAll() -> [T] {
        let request: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        do {
            let results: [T] = try context.fetch(request)
            return results
        } catch {
            fatalError("Error: \(error)")
        }
    }
    
    // Insert entity
    func insert(_ entity: T) throws -> T? {
        let context = entity.managedObjectContext != nil ? entity.managedObjectContext! : self.context
        context.insert(entity)
        if context.hasChanges {
            try context.save()
            return entity
        }
        return nil
    }
    
    // Update an entity
    func update(_ entity: T) throws -> T? {
        let context = entity.managedObjectContext != nil ? entity.managedObjectContext! : self.context
        if context.hasChanges {
            try context.save()
            return entity
        }
        return nil
    }
    
    // Delete an entity
    func delete(_ entity: T) throws -> Bool {
        let context = entity.managedObjectContext != nil ? entity.managedObjectContext! : self.context
        context.delete(entity)
        if context.hasChanges {
            try context.save()
            return true
        }
        return false
    }
    
    // Find entity using the given predicate
    func find(withPredicate: NSPredicate) -> [T] {
        let request: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        request.predicate = withPredicate
        
        do {
            let results: [T] = try context.fetch(request)
            return results
        } catch {
            fatalError("Error: \(error)")
        }
    }
    
}
