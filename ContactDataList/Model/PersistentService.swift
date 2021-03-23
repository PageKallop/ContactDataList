//
//  PersistentService.swift
//  ContactDataList
//
//  Created by Page Kallop on 3/21/21.
//

import Foundation
import CoreData

class PersistentService {
    
    private init(){
        
    }
    
    static let shared = PersistentService()
    
    var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    lazy var persistentContainer: NSPersistentContainer = {
   
        let container = NSPersistentContainer(name: "ContactDataList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
      
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
       
        return container
    }()

    // MARK: - Core Data Saving support

    func save () {
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
    
    
}
