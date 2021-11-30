//
//  UserDefaultManager.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 16/11/21.
//

import Foundation

struct UserDefaultsManager {
    let persistanceManager = UserDefaults.standard

    static let shared = UserDefaultsManager()

    private let onboardingKey: String = "OnboardingKey"
    private let customSoundsKey: String = "CustomSoundsKey"

    var isOnboardingDone: Bool {
        persistanceManager.bool(forKey: onboardingKey)
    }
    init() {

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
