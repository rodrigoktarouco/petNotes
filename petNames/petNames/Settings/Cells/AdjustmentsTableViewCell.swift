//
//  AdjustmentsTableViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 21/10/21.
//

import UIKit

class AdjustmentsTableViewCell: UITableViewCell {
    @IBOutlet weak var generalNotificationsLabel: UILabel!

    @IBAction func generalNotificationsSwitch(_ sender: UISwitch) {
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
