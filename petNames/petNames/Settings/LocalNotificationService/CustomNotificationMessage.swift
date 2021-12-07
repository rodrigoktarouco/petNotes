//
//  CustomNotificationMessage.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 06/12/21.
//

import Foundation

class CustomNotificationMessage {

  static func createCustomNotification(from taskType: TaskType) -> CustomNotification {
        let title: String
        let body: String
        switch taskType {
        case .water:
            title = "waterTitle".localized()
            body = "waterTimeBody".localized()
        case .feeding:
            title = "feedTitle".localized()
            body = "feedTimeBody".localized()
        case .wash:
            title = "bathTimeTitle".localized()
            body = "bathTimeBody".localized()
        case .playtime:
            title = "playTimeTitle".localized()
            body = "playTimeBody".localized()
        case .walk:
            title = "walkTitle".localized()
            body = "playTimeBody".localized()
        case .groom:
            title = "groomTitle".localized()
            body = "groomTimeBody".localized()
        case .medicine:
            title = "medicineTitle".localized()
            body = "medicineTimeBody".localized()
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
