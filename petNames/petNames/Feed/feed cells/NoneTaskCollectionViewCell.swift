//
//  NoneTaskCollectionViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 01/12/21.
//

import UIKit

class NoneTaskCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var backView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpFontsAndLabelTexts()
        setUpBackView()
        self.layer.cornerRadius = 22

    }

    func setUpFontsAndLabelTexts() {
        topLabel.text = "tasksSummary".localized()
        bottomLabel.text = "noTasksRegistered".localized()

        topLabel.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        bottomLabel.font = UIFont(name: "SFProRounded-Regular", size: 12)

        switch self.traitCollection.userInterfaceStyle {

        case .dark:
            topLabel.textColor = UIColor(red: 0.771, green: 0.771, blue: 0.771, alpha: 1)
            bottomLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        case .light:
            topLabel.textColor = UIColor(red: 0.321, green: 0.319, blue: 0.319, alpha: 1)
            bottomLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        case .unspecified:
            topLabel.textColor = UIColor(red: 0.321, green: 0.319, blue: 0.319, alpha: 1)
            bottomLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        @unknown default:
            topLabel.textColor = UIColor(red: 0.771, green: 0.771, blue: 0.771, alpha: 1)
            bottomLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }

    func setUpBackView() {

        switch self.traitCollection.userInterfaceStyle {

        case .dark:
            backView.layer.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.114, alpha: 1).cgColor
        case .light:
            backView.layer.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor

        case .unspecified:
            backView.layer.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor
        @unknown default:
            backView.layer.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor

        }
    }

}
