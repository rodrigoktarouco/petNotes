//
//  CustomNotificationMessage.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 06/12/21.
//

import Foundation

class CustomNotificationMessage {

    static func createCustomNotification(from taskType: TaskType, petName: String) -> CustomNotification {
        let user = PersistanceManager.shared.currentUser
        let title: String
        let body: String
        switch taskType {
        case .water:
            title = "waterTitle".localized()
            body = String(format: "waterTimeBody".localized(), petName)
        case .feeding:
            title = "feedTitle".localized()
            body = String(format: "feedTimeBody".localized(), petName)
        case .wash:
            title = "bathTimeTitle".localized()
            body = String(format: "bathTimeBody".localized(), petName)
        case .playtime:
            title = String(format: "playTimeTitle".localized(), user?.name ?? "Tutor")
            body = "playTimeBody".localized()
        case .walk:
            title = "walkTitle".localized()
            body = String(format: "playTimeBody".localized(), user?.name ?? "Tutor")
        case .groom:
            title = "groomTitle".localized()
            body = String(format: "groomTimeBody".localized(), user?.name ?? "Tutor")
        case .medicine:
            title = "medicineTitle".localized()
            body = String(format: "medicineTimeBody".localized(), petName)
        case .vet:
            title = "vetTimeTitle".localized()
            body = "vetTimeBody".localized()
        case .custom:
            title = "It's time to do your task"
            body = "Your pet needs you!"
        }
        return CustomNotification(title: title, body: body)
    }
}
struct CustomNotification {
    var title: String
    var body: String
}
