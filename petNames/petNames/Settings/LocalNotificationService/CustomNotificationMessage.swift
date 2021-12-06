//
//  CustomNotificationMessage.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 06/12/21.
//

import Foundation

class CustomNotificationMessage {

    lazy var playTime: CustomNotification = {
        var thisCustomNotification = CustomNotification(title: "playTimeTitle".localized(), body: "playTimeBody".localized())
        return thisCustomNotification
    }()

    lazy var bathTime: CustomNotification = {
        var thisCustomNotification = CustomNotification(title: "bathTimeTitle".localized(), body: "bathTimeBody".localized())
        return thisCustomNotification
    }()

    lazy var vetTime: CustomNotification = {       var thisCustomNotification = CustomNotification(title: "vetTimeTitle".localized(), body: "vetTimeBody".localized())
        return thisCustomNotification
    }()

    lazy var waterTime: CustomNotification = {
        var thisCustomNotification = CustomNotification(title: "waterTitle".localized(), body: "waterTimeBody".localized())
        return thisCustomNotification
    }()

    lazy var walkTime: CustomNotification = {
        var thisCustomNotification = CustomNotification(title: "walkTitle".localized(), body: "walkTimeBody".localized())
        return thisCustomNotification
    }()

    lazy var groomTime: CustomNotification = {
        var thisCustomNotification = CustomNotification(title: "groomTitle".localized(), body: "groomTimeBody".localized())
        return thisCustomNotification
    }()

    lazy var feedTime: CustomNotification = {
        var thisCustomNotification = CustomNotification(title: "feedTitle".localized(), body: "feedTimeBody".localized())
        return thisCustomNotification
    }()

    lazy var medicineTime: CustomNotification = {
        var thisCustomNotification = CustomNotification(title: "medicineTitle".localized(), body: "medicineTimeBody".localized())
        return thisCustomNotification
    }()
}

struct CustomNotification {
    var title: String
    var body: String
}


