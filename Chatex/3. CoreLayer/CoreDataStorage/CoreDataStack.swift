//
//  CoreDataStack.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 18/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let modelUrl = Bundle.main.url(forResource: "CoreDataModel", withExtension: "momd")!
    
    var storeUrl : URL {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsUrl.appendingPathComponent("Store1.sqlite")
    }
    
    lazy var managedObjectModel : NSManagedObjectModel = {
        return NSManagedObjectModel(contentsOf: modelUrl) ?? NSManagedObjectModel()
    }()
    
    lazy var persistentStoreCoordinator : NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        _ = try? coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
        return coordinator
    }()
    
    lazy var readContext : NSManagedObjectContext = {
        var readContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        readContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        readContext.mergePolicy = NSOverwriteMergePolicy
        return readContext
    }()
    
    lazy var saveContext : NSManagedObjectContext = {
        var saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        saveContext.parent = self.readContext
        saveContext.mergePolicy = NSOverwriteMergePolicy
        return saveContext
    }()
    
    func trySave(context : NSManagedObjectContext) {
        if context.hasChanges {
            try? context.save()
            if let contextParent = context.parent {
                trySave(context: contextParent)
            }
        }
    }
    
}
