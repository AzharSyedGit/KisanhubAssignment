//
//  CoreDataStack.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/17/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {

   lazy fileprivate var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HubAssignmentDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            guard error == nil else {
                fatalError("Unresolved error \(String(describing: error)), \(String(describing: error))")
            }
            storeDescription.type = NSSQLiteStoreType
            storeDescription.shouldInferMappingModelAutomatically = true
            storeDescription.shouldMigrateStoreAutomatically = true
        })
        return container
    }()
    
    //For fetching
    lazy var viewContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    //For write
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    func saveContext(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
}
