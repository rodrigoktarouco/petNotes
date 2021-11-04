//
//  TopInfosTableViewCell.swift
//  petNames
//
//  Created by Heitor Feijó Kunrath on 03/11/21.
//

import UIKit

class TopInfosTableViewCell: UITableViewCell {

    @IBOutlet weak var petImage: UIImageView!

    @IBOutlet weak var nameIsNext: UILabel!
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var categoryIsNext: UILabel!
    @IBOutlet weak var category: UILabel!

    @IBOutlet weak var tasksAreNextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        petImage.layer.cornerRadius = 22
        setUpFontStyle()
        setUpFuncColor()
        setUpLabelsTexts()
    }
    func setUpLabelsTexts() {
        nameIsNext.text = "name".localized().capitalized + ":"
        categoryIsNext.text = "category".localized().capitalized + ":"
        tasksAreNextLabel.text = "tasks".localized().capitalized

    }
    func setUpFuncColor() {
        nameIsNext.textColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1)
        name.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        categoryIsNext.textColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1)
        category.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        tasksAreNextLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    func setUpFontStyle () {
        nameIsNext.font = UIFont(name: "SFProRounded-Regular", size: 17)
        name.font = UIFont(name: "SFProRounded-Bold", size: 24)
        categoryIsNext.font = UIFont(name: "SFProRounded-Regular", size: 17)
        category.font = UIFont(name: "SFProRounded-Bold", size: 24)
        tasksAreNextLabel.font = UIFont(name: "SFProRounded-Semibold", size: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
