//
//  ApplicationDbContext.swift
//  cinego
//
//  Created by Josh MacDev on 30/9/17.
//  Copyright © 2017 ISE Superstars. All rights reserved.
//

import Foundation
import CoreData

class DatabaseController {
    
    private init() {}
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LocalDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    class func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    class func getContext() -> NSManagedObjectContext {
        return DatabaseController.persistentContainer.viewContext
    }
}







