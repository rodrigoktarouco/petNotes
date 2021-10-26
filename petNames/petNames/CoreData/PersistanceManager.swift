//
//  PersistanceManager.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 26/10/21.
//

import Foundation
import CoreData

class PersistanceManager {
    private init() {}
    static let shared = PersistanceManager()
    private var container: NSPersistentContainer!
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
   func setUp() {
        // MARK: - Core Data stack
        let container = NSPersistentContainer(name: "Model")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
       self.container = container
    }
    private func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func saveUser(user: User, completion: @escaping(Error?) -> Void) {
        saveContext()
        completion(nil)
    }
}

extension User {
    convenience init() {
        self.init(context: PersistanceManager.shared.context)
    }
}
