//
//  DataManager.swift
//  UdacityCocktailApp
//
//  Created by Kynan Song on 06/01/2019.
//  Copyright © 2019 Kynan Song. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    private let modelName: String
    let modelURL : URL
    var databaseURL : URL
    let managedObjectModel : NSManagedObjectModel
    let storeCoordinator: NSPersistentStoreCoordinator
    let persistedCOntext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext!
    let context: NSManagedObjectContext
    
    //Needed as extensions can't access datamanager properties.
    class func sharedInstance() -> DataManager {
        struct SingletonClass {
            static var sharedInstance = DataManager(modelName: "CocktailDataModel")
        }
        return SingletonClass.sharedInstance
    }
    
    //https://cocoacasts.com/setting-up-the-core-data-stack-from-scratch
    
    init(modelName: String) {
        self.modelName = modelName
        
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Data model not found.")
        }
        self.modelURL = modelURL
        
        //Model is created from the URL
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Data model could not be loaded.")
        }
        self.managedObjectModel = managedObjectModel
        
        storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        persistedCOntext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        persistedCOntext.persistentStoreCoordinator = storeCoordinator
        
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = persistedCOntext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = context
        
        //Access SQLite database. Has to be done in init as due to issues of being called before initialisation.
        //Only functional once the store is added to the coordinator.
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        guard let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            //Need to use .first as opposed to [0].
            fatalError("Folder could not be reached.")
        }
        self.databaseURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        //Database migration
        let migration = [NSInferMappingModelAutomaticallyOption: true, NSMigratePersistentStoresAutomaticallyOption: true]
        
        do {
            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: databaseURL, options: migration as [NSObject:AnyObject]?)
        } catch {
            fatalError("Persistant store not found.")
        }
    }
}

extension DataManager {
    
    //saving context
    //https://www.hackingwithswift.com/read/38/3/adding-core-data-to-our-project-nspersistentcontainer
    
    func saveContext() throws {
        context.performAndWait {
            if self.context.hasChanges {
                do {
                    try self.context.save()
                } catch {
                    print("\(error): Unable to save context.")
                }
                
                //Run background saving.
                self.persistedCOntext.perform {
                    do {
                        try self.persistedCOntext.save()
                    } catch {
                        print("\(error): Unable to save persisted context.")
                    }
                }
            }
        }
    }
}
