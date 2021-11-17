//
//  AppDelegate.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 06/10/21.
//
// user.name = "unamedUser" fazer loc depis
import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 3.0)
        LocalNotificationService.initialize()
        UNUserNotificationCenter.current().delegate = self
        // Override point for customization after application launch.
        //
        //print("Application directory: \(NSHomeDirectory())")
        
        PersistanceManager.shared.setUp()
        PersistanceManager.shared.loadUser { result in
            switch result {
            case .failure(PersistenceError.notSignedIn):
                let user = User()
                user.name = "unamedUser"

                PersistanceManager.shared.saveUser(user: user) { _ in }

            default:
                return
            }
            
        }

        let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        window?.overrideUserInterfaceStyle = .unspecified

        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .banner])
    }

//    func testCreatePet() {
//        let pet = Pet()
//        pet.name = "belinha"
//        pet.petCategory = .bird
//
//
//        let task1 = Task()
//        task1.name = "vet"
//        task1.alertTimes = [
//            DateComponents(hour: 10, minute: 30),
//            DateComponents(hour: 4, minute: 20),
//            DateComponents(hour: 9, minute: 9)
//        ]
//        task1.taskRepetition = .daily
//        task1.observations = " S xXguilhermeXx e xXrodrigoXx 2"
//
//        let task2 = Task()
//        task2.name = "shower"
//        task2.alertTimes = [
//            DateComponents(hour: 16, minute: 20),
//        ]
//        task2.taskRepetition = .never
//
//        let task3 = Task()
//        task3.name = "water"
//        task3.taskRepetition = .never
//
//        task1.pet = pet
//        task2.pet = pet
//        task3.pet = pet
//
//        pet.tasks = [
//            task1,
//            task2,
//            task3
//        ]
//
//        PersistanceManager.shared.savePet(pet: pet) { error in
//            print(error)
//        }
//
//    }
//    func listPets() {
//        PersistanceManager.shared.listPets() { result in
//            switch result {
//            case .success(let pets):
//                print(pets)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }

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
