//
//  UserDefaultManager.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 16/11/21.
//

import Foundation

class UserDefaultsManager {
    let persistanceManager = UserDefaults.standard

    static let shared = UserDefaultsManager()

    private let onboardingKey: String = "OnboardingKey"
    private let customSoundsKey: String = "CustomSoundsKey"
    private let notificationsEnabled: String = "NotificationsEnabled"
    private let disableTaskNotifications: String = "disableTaskNotifications"

    var isOnboardingDone: Bool {
        persistanceManager.bool(forKey: onboardingKey)
    }
    init() {

    }

    var notificationsIsEnabled: Bool {
        get {
            persistanceManager.bool(forKey: notificationsEnabled)
        }

        set {
            persistanceManager.set(newValue, forKey: notificationsEnabled)
        }
    }

    var taskNotificationsIsDisabled: [String] {
        get {
            persistanceManager.array(forKey: disableTaskNotifications) as? [String] ?? []
        }

        set {
            persistanceManager.set(newValue, forKey: disableTaskNotifications)
        }
    }

    var isCustomSoundEffectsEnabled: Bool {
        persistanceManager.bool(forKey: customSoundsKey)
    }

    func saveOnboardingStatus(status: Bool) {
        persistanceManager.set(status, forKey: onboardingKey)
    }

    func saveCustomSoundEffectsStatus(status: Bool) {
        persistanceManager.set(status, forKey: customSoundsKey)
    }
}
