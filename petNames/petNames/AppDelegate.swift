//
//  AppDelegate.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 06/10/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        PersistanceManager.shared.setUp()
        //        let user = User.init(context: persistentContainer.viewContext)
//        user.name = "Heitor"
//        user.id = "1"
//        let pet = Pet.init(context: persistentContainer.viewContext)
//        pet.id = "2"
//        pet.name = "Pitty"
//        pet.user = user
//        pet.category = "Dog"
//        pet.image = ""
//        pet.share = ""
//        saveContext()
//        let fetchRequest = Pet.fetchRequest()
//        do {
//            let results = try persistentContainer.viewContext.fetch(fetchRequest)
//            let pet = results[0] as Pet
//            print(pet.name, pet.user?.name)
//        } catch {
//            print(error)
//        }
        return true
    }
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
