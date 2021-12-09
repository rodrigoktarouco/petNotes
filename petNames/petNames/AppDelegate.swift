//
//  AppDelegate.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 06/10/21.
//
// user.name = "unamedUser" fazer loc depis
import UIKit
import CoreData
import UserNotifications

public var isDarkModeOn: Bool = false

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Application directory: \(NSHomeDirectory())")
        let dcf = DateComponentsFormatter()
        dcf.unitsStyle = .abbreviated
        dcf.allowedUnits = [.year, .month, .day, .hour, .minute, .second]

        UNUserNotificationCenter.current().getPendingNotificationRequests { pending in
            let ttt = pending.map { req -> String in
                return "\(req.identifier)-\(req.content.title) (\(req.content.subtitle) - \(req.content.body)) -- \(req.trigger)"
            }
                .joined(separator: "\n")
            print("pending notification requests -- \n\(ttt)")

            UNUserNotificationCenter.current().getDeliveredNotifications { delivered in
                let ppp = delivered.map { not -> String in
                    let req = not.request
                    return "\(not.date) -- \(req.content.title) (\(req.content.subtitle) - \(req.content.body)) -- \(req.trigger)"
                }
                    .joined(separator: "\n")
                print("delivered notifications -- \n\(ppp)")
            }
        }
        Thread.sleep(forTimeInterval: 3.0)
        LocalNotificationService.initialize()
        UNUserNotificationCenter.current().delegate = self
        // Override point for customization after application launch.
        //

        
        PersistanceManager.shared.setUp()
        PersistanceManager.shared.loadUser { _ in
            //            switch result {
            //            case .failure(PersistenceError.notSignedIn):
            //                let user = User()
            //                user.name = "unamedUser"
            //
            //                PersistanceManager.shared.saveUser(user: user) { _ in }
            //
            //            default:
            //                return
            //            }

            if UITraitCollection.current.userInterfaceStyle == .dark {
                isDarkModeOn = true
            } else {
                isDarkModeOn = false
            }
        }

        let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        window?.overrideUserInterfaceStyle = .unspecified

        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .banner])
        SoundService.shared.playButtonEffects()
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
