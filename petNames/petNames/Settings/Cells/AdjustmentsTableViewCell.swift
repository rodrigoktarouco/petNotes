//
//  AdjustmentsTableViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 21/10/21.
//

import UIKit
import UserNotifications

class AdjustmentsTableViewCell: UITableViewCell {
    @IBOutlet weak var generalNotificationsLabel: UILabel!
    @IBOutlet weak var generalNotificationsSwitch: UISwitch!

    private let localNotificationService = LocalNotificationService.shared

    @IBAction func generalNotificationsSwitch(_ sender: UISwitch) {
        if sender.isOn {
            // Ask for user enable notifications on Settings
            LocalNotificationService.shared.requestAuthorizationIfNeeded { [self] success in
                DispatchQueue.main.async {
                    guard success else {
                        sender.isOn = false
                        return
                    }
                }
                
            }
        } else {
            // Unschedule all user's notifications
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.localNotificationService.remove(identifiers: [.task])
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setFontStyle()
        setLocalizablesForLabels()

//        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)

    }
   func setLocalizablesForLabels() {
       generalNotificationsLabel.text = "generalNotifications".localized()
    }

    func setFontStyle() {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
