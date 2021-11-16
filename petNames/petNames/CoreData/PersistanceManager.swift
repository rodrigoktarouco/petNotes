//
//  PersistanceManager.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 26/10/21.
//

import Foundation
import CoreData
import UIKit

enum PersistenceError: Error {
    case notSignedIn
}

enum TaskRepetition: String {
    case never
    case daily
}

enum PetCategory: String {
    case dog
    case cat
    case bird
    case other
}

class PersistanceManager {
    private init() {}
    static let shared = PersistanceManager()
    private var container: NSPersistentContainer!
    var context: NSManagedObjectContext {
        container.viewContext
    }
    var currentUser: User?

    func setUp() {
        // MARK: - Core Data stack
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (_, error) in
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func loadUser(completion: @escaping(Result<User, Error>) -> Void) {
        let fetchRequest = User.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            if let user = results.first {
                self.currentUser = user
                completion(.success(user))
            } else {
                completion(.failure(PersistenceError.notSignedIn))
            }
        } catch {
            print(error)
            completion(.failure(error))
        }
    }

    func saveUser(user: User, completion: @escaping(Error?) -> Void) {
        saveContext()
        completion(nil)
    }

    func getPetImage(_ pet: Pet, completion: @escaping(UIImage?) -> Void) {

        let imageName = pet.image ?? "\(UUID().uuidString).jpg"
        var url = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask)[0]
        url.appendPathComponent("\(imageName)")
        do {
            let imageData = try Data(contentsOf: url)
            let image = UIImage(data: imageData)
            completion(image)
        } catch {
            print(error)
            completion(nil)
        }

    }

    func savePet(pet: Pet, petImage: UIImage?, completion: @escaping(Error?) -> Void) {
        pet.user = currentUser
        let imageName = pet.image ?? "\(UUID().uuidString).jpg"
        var url = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask)[0]
        url.appendPathComponent("\(imageName)")

        if let petImage = petImage {
            let data = petImage.jpegData(compressionQuality: 1)
            do {
                try data?.write(to: url)
                pet.image = imageName
            } catch {
                print(error)
            }
        } else {
            do {
                try FileManager.default.removeItem(at: url)
                pet.image = nil
            } catch {
                print(error)
            }
        }
        if let pets = currentUser?.pets {

            currentUser?.pets = pets.adding(pet) as NSSet
        } else {
            currentUser?.pets = [pet]
        }
        saveContext()
        completion(nil)

    }

    func saveTask( task: Task, completion: @escaping(Error?) -> Void ) {
        saveContext()
        completion(nil)
    }

    func listPets(completion: @escaping(Result<[Pet], Error>) -> Void) {
        let pets = (currentUser?.pets ?? []).compactMap { $0 as? Pet }
        completion(.success(pets))

    }

    func listTasksFromPet(pet: Pet, completion: @escaping(Result<[Task], Error>) -> Void) {
        let tasks: [Task] = (pet.tasks ?? []).compactMap { $0 as? Task }
        completion(.success(tasks))

    }

    func listAllTasks( completion: @escaping(Result<[Task], Error>) -> Void) {

        let fetchRequest = Task.fetchRequest()
        do {
            let tasks = try context.fetch(fetchRequest)
            completion(.success(tasks))
        } catch {
            print(error)
            completion(.failure(error))
        }
    }
}

extension User {
    convenience init() {
        self.init(context: PersistanceManager.shared.context)
    }
}

extension Pet {
    var petCategory: PetCategory {
        get {
            if let category = category {
                return PetCategory.init(rawValue: category) ?? .other
            }
            return .other
        }
        set {
            category = newValue.rawValue
        }
    }

    convenience init() {
        self.init(context: PersistanceManager.shared.context)
    }
}

extension Task {
    var taskRepetition: TaskRepetition? {
        get {
            if let repetition = repetition {
                return TaskRepetition(rawValue: repetition)
            }
            return nil
        }
        set {
            repetition = newValue?.rawValue
        }
    }

    var alertTimes: [DateComponents] {
        get {
            // "hh:mm|hh:mm|hh:mm"
            let alertString = alerts ?? String()
            let timeStrings = alertString.components(separatedBy: "|")
            var components: [DateComponents] = []

            for time in timeStrings {
                let timeComponents = time.components(separatedBy: ":")
                if let hourString = timeComponents.first, let hour = Int(hourString),
                   let minutesString = timeComponents.last, let minutes = Int(minutesString) {
                    var dateComponents = DateComponents()
                    dateComponents.timeZone = TimeZone(secondsFromGMT: 0)
                    dateComponents.hour = hour
                    dateComponents.minute = minutes
                    components.append(dateComponents)
                }
            }
            return components
        }
        set {
            var alertStrings: [String] = []
            for timeComponents in newValue {
                alertStrings.append("\(timeComponents.hour ?? 0):\(timeComponents.minute ?? 0)")
            }
            alerts =  alertStrings.joined(separator: "|")
        }
    }

    convenience init() {
        self.init(context: PersistanceManager.shared.context)
    }
}

extension Execution {
    convenience init() {
        self.init(context: PersistanceManager.shared.context)
    }
}
