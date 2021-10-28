//
//  FeedModel.swift
//  petNames
//
//  Created by Rodrigo Kroef Tarouco on 14/10/21.
//

import Foundation
import UIKit

enum TaskTypes {
case water
case feeding
case wash
case playtime
case walk
case groom
case medicine
case vet
case custom
}
class FeedModel {
    
static let sharedFeedModel = FeedModel()
    
    func getTaskColor ( _ taskType: TaskTypes) -> UIColor {
        switch taskType {
        case .water :
            return UIColor(red: 0.898, green: 1, blue: 1, alpha: 1)
        case .feeding :
            return UIColor(red: 1, green: 0.947, blue: 0.898, alpha: 1)
        case .wash :
            return UIColor(red: 0.937, green: 0.898, blue: 1, alpha: 1)
        case .playtime :
            return UIColor(red: 1, green: 0.898, blue: 0.996, alpha: 1)
        case .walk :
            return UIColor(red: 0.898, green: 1, blue: 0.908, alpha: 1)
        case .medicine :
            return UIColor(red: 1, green: 0.898, blue: 0.898, alpha: 1)
        case .groom :
            return UIColor(red: 1, green: 0.978, blue: 0.898, alpha: 1)
        case .vet :
            return UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1)
        case .custom :
            return UIColor(red: 0.898, green: 0.949, blue: 1, alpha: 1)
        default:
            return UIColor(red: 0.898, green: 0.949, blue: 1, alpha: 1)
            
        }
    }
    
}
