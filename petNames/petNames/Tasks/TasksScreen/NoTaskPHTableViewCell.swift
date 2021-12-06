//
//  NoTaskPHTableViewCell.swift
//  petNames
//
//  Created by Enzo Degrazia on 03/12/21.
//

import UIKit

class NoTaskPHTableViewCell: UITableViewCell {

    @IBOutlet var noTaskLabel: UILabel!
    @IBOutlet var noTaskBottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpFontsAndLabelTexts()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
    }
    
    func setUpFontsAndLabelTexts() {
        noTaskLabel.text = "tasksSummary".localized()
        noTaskBottomLabel.text = "noTasksRegistered".localized()

        noTaskLabel.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        noTaskBottomLabel.font = UIFont(name: "SFProRounded-Regular", size: 12)

        switch self.traitCollection.userInterfaceStyle {

        case .dark:
            noTaskLabel.textColor = UIColor(red: 0.771, green: 0.771, blue: 0.771, alpha: 1)
            noTaskBottomLabel.textColor = UIColor(red: 0.771, green: 0.771, blue: 0.771, alpha: 1)
        case .light:
            noTaskLabel.textColor = UIColor(red: 0.321, green: 0.319, blue: 0.319, alpha: 1)
            noTaskBottomLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        case .unspecified:
            noTaskLabel.textColor = UIColor(red: 0.321, green: 0.319, blue: 0.319, alpha: 1)
            noTaskBottomLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        @unknown default:
            noTaskLabel.textColor = UIColor(red: 0.771, green: 0.771, blue: 0.771, alpha: 1)
            noTaskBottomLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
