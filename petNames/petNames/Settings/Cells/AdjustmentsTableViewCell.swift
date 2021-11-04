//
//  AdjustmentsTableViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 21/10/21.
//

import UIKit

class AdjustmentsTableViewCell: UITableViewCell {
    @IBOutlet weak var adjustmentsTitleLabel: UILabel!
    @IBOutlet weak var generalNotificationsLabel: UILabel!
    @IBOutlet weak var soundEfectsLabel: UILabel!
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var adjustmentsView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        setFontStyle()
        setLocalizablesForLabels()

        adjustmentsView.layer.cornerRadius = 12
//        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)

    }
   func setLocalizablesForLabels() {
       generalNotificationsLabel.text = "generalNotifications".localized()
       soundEfectsLabel.text = "soundEfects".localized()
       darkModeLabel.text = "darkMode".localized()
       adjustmentsTitleLabel.text = "adjustmendsTitle".localized()
    }

    func setFontStyle() {
        adjustmentsTitleLabel.font = UIFont(name: "SFProRounded-Semibold", size: 20)
        let labels = [generalNotificationsLabel, soundEfectsLabel, darkModeLabel]
        for label in labels {
            label?.font = UIFont(name: "SFProRounded-Regular", size: 17)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
