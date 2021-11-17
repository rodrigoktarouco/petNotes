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

    var isOnboardingDone: Bool {
        persistanceManager.bool(forKey: onboardingKey)
    }
    init() {

    }

    func saveOnboardingStatus(status: Bool) {
        persistanceManager.set(status, forKey: onboardingKey)
    }
}
