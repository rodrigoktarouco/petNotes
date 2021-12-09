//
//  LocalNotificationService.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 08/11/21.
//

import Foundation
import UserNotifications

final class LocalNotificationService {

    // MARK: - Properties
    private static var instance: LocalNotificationService?
    private let notificationCenter: UNUserNotificationCenter = .current()
    // MARK: - Single Instance
    static var shared: LocalNotificationService {
        guard let instance = instance else {
            preconditionFailure()
        }
        return instance
    }

    // MARK: - Initializer
    private init() {
    }

    static func initialize() {
        guard instance == nil else {
            preconditionFailure()
        }
        instance = LocalNotificationService()
    }

    // MARK: - Public API
    func schedule(
        notifications: [Notification],
        completion: (() -> Void)? = nil
    ) {
        requestAuthorizationIfNeeded { [self] success in
            UserDefaultsManager.shared.notificationsIsEnabled = success
            guard success else {
                completion?()
                return
            }
            registerNewLocalNotifications(notifications: notifications, completion: completion)
        }
    }

    // MARK: - Private API
    private func registerNewLocalNotifications(
        notifications: [Notification],
        completion: (() -> Void)? = nil
    ) {
        notifications.forEach { notification in

            // Configure the content
            let content = UNMutableNotificationContent()
            content.configure(notification: notification)

            // Configure the trigger
            let dateComponentes = createDateComponents(notification: notification)
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponentes,
                repeats: true // Every day
            )

            // Configure the request to schedule the local notification
            let request = UNNotificationRequest(
                identifier: notification.id,
                content: content,
                trigger: trigger
            )

            notificationCenter.add(request)
        }
        completion?()
    }

    private func createDateComponents(notification: Notification) -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.timeZone = .current
        dateComponents.hour = notification.hour
        dateComponents.minute = notification.minutes
        return dateComponents
    }

    // MARK: - Permissions
    private func requestAuthorization(completion: @escaping (Bool) -> Void) {
        notificationCenter.requestAuthorization(
            options: [.alert, .badge, .sound],
            completionHandler: { success, _ in
                completion(success)
            }
        )
    }

     func requestAuthorizationIfNeeded(completion: @escaping (Bool) -> Void) {
        notificationCenter.getNotificationSettings { [self] settings in
            let notDetermined = settings.authorizationStatus == .notDetermined || settings.authorizationStatus == .denied
            if notDetermined {
                requestAuthorization(completion: completion)
            } else {
                completion(!notDetermined)
            }
        }
    }

    func isPermissionsEnabled(completion: @escaping (Bool) -> Void) {
        notificationCenter.getNotificationSettings { settings in
            completion(settings.authorizationStatus == .authorized)
        }
    }

    func scheduleTasks(for pet: Pet) {
        unscheduleTasks(for: pet) {
            let petID = pet.objectID.uriRepresentation().absoluteString
            let tasks = pet.tasks?.allObjects as? [Task] ?? []
            var notifications = [Notification]()
            for task in tasks {
                let taskID = task.objectID.uriRepresentation().absoluteString
                print("Trying to schedule notifications for task \(taskID)")
                if UserDefaultsManager.shared.taskNotificationsIsDisabled.contains(taskID) {
                    print("Skiping schedule of notifications for task \(taskID): toogle disabled")
                    continue
                }
                let taskType = TaskType(name: task.name!)
                let customNotification = CustomNotificationMessage.createCustomNotification(from: taskType, petName: pet.name ?? "Pet")
                for alertTime in task.alertTimes {
                    var utcCalendar = Calendar.autoupdatingCurrent
                    utcCalendar.timeZone = TimeZone(identifier: "UTC") ?? .autoupdatingCurrent
                    var baseComps = utcCalendar.dateComponents(in: utcCalendar.timeZone, from: Date())
                    baseComps.hour = alertTime.hour
                    baseComps.minute = alertTime.minute
                    let date = utcCalendar.date(from: baseComps) ?? Date()
                    let finalComps = Calendar.autoupdatingCurrent.dateComponents([.hour, .minute], from: date)
                    let hour = finalComps.hour ?? 0
                    let minute = finalComps.minute ?? 0
                    let alertId = "\(petID)-\(taskID)-\(hour):\(minute)"

                    let newNotification = Notification(id: alertId, title:
                                                        customNotification.title, body: customNotification.body, hour: hour, minutes: minute)
                    notifications.append(newNotification)
                }
            }
            self.schedule(notifications: notifications, completion: nil)
        }
    }

    func unscheduleTasks(for pet: Pet, completion: @escaping() -> Void) {
        let petID = pet.objectID.uriRepresentation().absoluteString
        self.notificationCenter.getPendingNotificationRequests { requests in
            let toDelete = requests.filter { $0.identifier.starts(with: petID) }
                .map(\.identifier)
        self.notificationCenter.removePendingNotificationRequests(withIdentifiers: toDelete)
            completion()
        }
    }
}

// API Extension to configure the local notification
extension UNMutableNotificationContent {
    func configure(notification: Notification) {
        title = notification.title
        body = notification.body
        sound = .default
    }
}

// MARK: - Model
struct Notification: Hashable, Codable {
    let id: String
    let title: String
    let body: String
    let hour: Int
    var minutes: Int

    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
