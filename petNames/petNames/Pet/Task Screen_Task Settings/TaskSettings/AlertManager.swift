//
//  AlertManager.swift
//  petNames
//
//  Created by Enzo Degrazia on 11/11/21.
//

import Foundation
import UIKit

class AlertManager {
    init() {}
     static var shared = AlertManager()
    
    func createAlert(title: String, message: String, viewC: UIViewController) {
        let alertController: UIAlertController = {
            let controller = UIAlertController(title: title,
                                               message: message,
                                               preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            controller.addAction(action)
            return controller
        }()
        viewC.present(alertController, animated: true)
    }
}
