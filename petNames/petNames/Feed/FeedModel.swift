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
case shower
case playTime
case takeAWalk
case tosa // traduzir!!!!
case medicine
case vet
case personalized
}
class FeedModel {
    
static let sharedFeedModel = FeedModel()
    
    func getTaskColor ( _ taskType: TaskTypes) -> UIColor {
        switch taskType {
        case .water :
            return UIColor(red: 0.898, green: 1, blue: 1, alpha: 1)
        case .feeding :
            return UIColor(red: 1, green: 0.947, blue: 0.898, alpha: 1)
        case .shower :
            return UIColor(red: 0.937, green: 0.898, blue: 1, alpha: 1)
        case .playTime :
            return UIColor(red: 1, green: 0.898, blue: 0.996, alpha: 1)
        case .takeAWalk :
            return UIColor(red: 0.898, green: 1, blue: 0.908, alpha: 1)
        case .medicine :
            return UIColor(red: 1, green: 0.898, blue: 0.898, alpha: 1)
        case .tosa : // traduzir!!!!
            return UIColor(red: 1, green: 0.978, blue: 0.898, alpha: 1)
        case .vet :
            return UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1)
        case .personalized :
            return UIColor(red: 0.898, green: 0.949, blue: 1, alpha: 1)
        default:
            return UIColor(red: 0.898, green: 0.949, blue: 1, alpha: 1)
            
        }
    }
    
}
