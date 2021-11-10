//
//  AdjustmentsTableViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 21/10/21.
//

import UIKit
import UserNotifications

protocol AdjustmentsTableViewCellDelegate: AnyObject {
    func didToogleSwitch(cellType: AdjustmentsCellType, isOn: Bool)
}
enum AdjustmentsCellType {
    case notifications
    case soundEffects
    case darkMode
}

class AdjustmentsTableViewCell: UITableViewCell {
    @IBOutlet weak var generalNotificationsLabel: UILabel!
    @IBOutlet weak var generalNotificationsSwitch: UISwitch!

    weak var delegate: AdjustmentsTableViewCellDelegate?
    var cellType: AdjustmentsCellType?

    @IBAction func generalNotificationsSwitch(_ sender: UISwitch) {
        if let cellType = cellType {
            delegate?.didToogleSwitch(cellType: cellType, isOn: sender.isOn)
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
