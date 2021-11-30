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
    private static var localNotificationsIdentifier = "local-notifications"
    private var notificationsContainer: Set<Notification> = []
    private let notificationCenter: UNUserNotificationCenter = .current()
    private let userDefaults: UserDefaults = .standard
    private let encoder: JSONEncoder = .init()
    private let decoder: JSONDecoder = .init()
    // MARK: - Single Instance
    static var shared: LocalNotificationService {
        guard let instance = instance else {
            preconditionFailure()
        }
        return instance
    }

    // MARK: - Initializer
    private init() {
        guard let storedNotifications = getStoredNotifications() else {
            return
        }
        notificationsContainer = storedNotifications
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
            guard success else {
                completion?()
                return
            }

            let notificationsNotStored = notifications
                .filter(validateNotification(notification:))

            notificationsNotStored
                .forEach { notificationsContainer.insert($0) }

            registerNewLocalNotifications(notifications: notificationsNotStored, completion: completion)
        }
    }

    func remove(identifiers: [String], completion: (() -> Void)? = nil) {
        identifiers.forEach { identifier in
            notificationCenter.removeDeliveredNotifications(withIdentifiers: [identifier])
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])

            if let index = notificationsContainer.firstIndex(where: { element in
                element.id.uuidString == identifier
            }) {
                notificationsContainer.remove(at: index)
            }
        }
        storeNotifications()
        completion?()
    }

    func removeAll() {
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.removeAllDeliveredNotifications()
        notificationsContainer.removeAll()
        userDefaults.removeObject(forKey: Self.localNotificationsIdentifier)
    }

    func scheduledNotifications() -> [Notification] {
        Array(notificationsContainer)
    }

    // MARK: - Private API
    private func validateNotification(notification: Notification) -> Bool {
        notificationsContainer.contains(notification) == false
    }

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
                identifier: notification.id.uuidString,
                content: content,
                trigger: trigger
            )

            notificationCenter.add(request)
        }

        storeNotifications()
        completion?()
    }

    private func createDateComponents(notification: Notification) -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.timeZone = .current
        dateComponents.hour = notification.hour
        dateComponents.minute = notification.minutes
        return dateComponents
    }

    // MARK: - UserDefaults
    private func getStoredNotifications() -> Set<Notification>? {
        guard
            let data = userDefaults.object(forKey: Self.localNotificationsIdentifier) as? Data,
            let object = try? decoder.decode(Set<Notification>.self, from: data)
        else {
            return nil
        }
        return object
    }

    private func storeNotifications() {
        userDefaults.removeObject(forKey: Self.localNotificationsIdentifier)

        if let data = try? encoder.encode(notificationsContainer) {
            userDefaults.set(data, forKey: Self.localNotificationsIdentifier)
        }
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
}

// API Extension to configure the local notification
extension UNMutableNotificationContent {
    func configure(notification: Notification) {
        categoryIdentifier = notification.id.uuidString
        title = notification.title
        body = notification.body
        sound = .default
    }
}

// MARK: - Model
struct Notification: Hashable, Codable {
    let id: UUID = UUID()
    let title: String
    let body: String
    let hour: Int
    var minutes: Int

    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
